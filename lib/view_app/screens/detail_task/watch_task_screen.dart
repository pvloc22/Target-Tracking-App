import 'package:flutter/material.dart';
import 'package:app/core/style/colors.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'dart:async';
import 'package:app/view_app/widgets/task_success_dialog.dart';
import 'package:app/view_app/widgets/warning_dialog.dart';

import 'detail_task_screen.dart';


class WatchTaskScreen extends StatefulWidget {
  const WatchTaskScreen({super.key});

  @override
  State<WatchTaskScreen> createState() => _WatchTaskScreenState();
}

class _WatchTaskScreenState extends State<WatchTaskScreen> with TickerProviderStateMixin {
  CountDownController? _countDownController;
  CountDownController? _pomodoroController;

  bool _isTimerRunning = false;
  bool _isPaused = false;
  int _selectedTimerType = 0; // 0: countdown, 1: stopwatch, 2: pomodoro
  bool _isDisposed = false;

  // Stopwatch variables
  late Stopwatch _stopwatch;
  Timer? _stopwatchTimer;
  String _stopwatchDisplay = "00:00:00";

  // Pomodoro variables
  int _pomodoroWorkMinutes = 25;
  int _pomodoroBreakMinutes = 5;
  int _pomodoroLongBreakMinutes = 15;
  int _pomodoroTotalSeconds = 25 * 60; // 25 minutes
  bool _isWorkTime = true;
  int _pomodoroSession = 1;
  int _maxPomodoroSessions = 4;

  // Sample timesheet entries
  final List<Map<String, dynamic>> _timesheetEntries = [
    {
      'description': 'Reading comprehension practice - completed first section with 85% accuracy',
      'minutes': 21,
      'type': 'study', // study, break, focus
    },
    {
      'description': 'Vocabulary review - focused on business terminology and common phrases',
      'minutes': 21,
      'type': 'break',
    },
    {
      'description': 'Listening practice - completed 20 questions with detailed analysis of mistakes',
      'minutes': 21,
      'type': 'focus',
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _stopwatch = Stopwatch();
    _stopwatchTimer = Timer.periodic(const Duration(milliseconds: 100), _updateStopwatch);
  }

  void _initializeControllers() {
    _countDownController = CountDownController();
    _pomodoroController = CountDownController();
  }

  @override
  void dispose() {
    _isDisposed = true;
    _stopwatchTimer?.cancel();
    super.dispose();
  }

  void _updateStopwatch(Timer timer) {
    if (_stopwatch.isRunning && !_isDisposed) {
      setState(() {
        final hours = (_stopwatch.elapsed.inHours).toString().padLeft(2, '0');
        final minutes = (_stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, '0');
        final seconds = (_stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0');
        _stopwatchDisplay = "$hours:$minutes:$seconds";
      });
    }
  }

  void _pomodoroFinished() {
    if (_isDisposed) return;

    setState(() {
      if (_isWorkTime) {
        // Work session finished, show dialog
        _showTaskSuccessDialog("Tuyệt vời!", "Bạn đã hoàn thành một phiên làm việc. Bạn có muốn lưu lại thông tin không?");

        // Start break
        _isWorkTime = false;
        _pomodoroTotalSeconds = _pomodoroBreakMinutes * 60;
        _pomodoroController = CountDownController(); // Create a new controller
      } else {
        // Break finished, start work or end sessions
        _pomodoroSession++;
        if (_pomodoroSession > _maxPomodoroSessions) {
          // All sessions completed
          _showTaskSuccessDialog("Hoàn thành!", "Bạn đã hoàn thành tất cả các phiên làm việc Pomodoro. Nhấn 'Lưu' để lưu lại thông tin.");
          _isTimerRunning = false;
        } else {
          _isWorkTime = true;
          _pomodoroTotalSeconds = _pomodoroWorkMinutes * 60;
          _pomodoroController = CountDownController(); // Create a new controller
        }
      }
    });
  }

  void _startStopTimer() {
    if (_isDisposed) return;

    setState(() {
      if (_isTimerRunning) {
        // Pause the timer
        switch (_selectedTimerType) {
          case 0: // countdown
            _countDownController?.pause();
            break;
          case 1: // stopwatch
            _stopwatch.stop();
            break;
          case 2: // pomodoro
            _pomodoroController?.pause();
            break;
        }
        _isPaused = true;
      } else {
        if (_isPaused) {
          // Resume the timer
          switch (_selectedTimerType) {
            case 0: // countdown
              _countDownController?.resume();
              break;
            case 1: // stopwatch
              _stopwatch.start();
              break;
            case 2: // pomodoro
              _pomodoroController?.resume();
              break;
          }
          _isPaused = false;
        } else {
          // Start the timer
          switch (_selectedTimerType) {
            case 0: // countdown
              _countDownController?.start();
              break;
            case 1: // stopwatch
              _stopwatch.start();
              break;
            case 2: // pomodoro
              _pomodoroController?.start();
              break;
          }
        }
      }
      _isTimerRunning = !_isTimerRunning;
    });
  }

  void _stopTimer() {
    if (_isDisposed) return;

    setState(() {
      switch (_selectedTimerType) {
        case 0: // countdown
          if (_countDownController != null) {
            // Get elapsed time for countdown
            int elapsed = 10; // Placeholder - would need to calculate from duration and remaining time
            _showWarningDialog("Dừng bộ đếm & ghi lại hoạt động",
                "Bộ đếm thời gian đã bị dừng. Vui lòng ghi lại những gì bạn đã làm trong $elapsed phút.");
          } else {
            _countDownController?.reset();
          }
          break;
        case 1: // stopwatch
          if (_stopwatch.elapsed.inSeconds > 0) {
            _showWarningDialog("Dừng bộ đếm & ghi lại hoạt động",
                "Bộ đếm thời gian đã bị dừng. Vui lòng ghi lại những gì bạn đã làm trong ${_stopwatch.elapsed.inMinutes} phút.");
          } else {
            _stopwatch.reset();
            _stopwatchDisplay = "00:00:00";
          }
          break;
        case 2: // pomodoro
          if (_pomodoroController != null && _isTimerRunning) {
            int elapsed = (_isWorkTime ? _pomodoroWorkMinutes : _pomodoroBreakMinutes) * 60; // Placeholder - would calculate actual elapsed time
            _showWarningDialog("Dừng Pomodoro & ghi lại hoạt động",
                "Phiên Pomodoro đã bị dừng. Vui lòng ghi lại những gì bạn đã làm trong phiên này.");
          } else {
            _pomodoroController?.reset();
            _isWorkTime = true;
            _pomodoroSession = 1;
          }
          break;
      }
      _isTimerRunning = false;
      _isPaused = false;
    });
  }

  void _resetTimer() {
    if (_isDisposed) return;

    setState(() {
      switch (_selectedTimerType) {
        case 0: // countdown
        // Create a new controller instead of restarting the existing one
          _countDownController = CountDownController();
          _isTimerRunning = false;
          break;
        case 1: // stopwatch
          _stopwatch.reset();
          _stopwatchDisplay = "00:00:00";
          _isTimerRunning = false;
          break;
        case 2: // pomodoro
        // Create a new controller instead of restarting the existing one
          _pomodoroController = CountDownController();
          _isWorkTime = true;
          _pomodoroSession = 1;
          _pomodoroTotalSeconds = _pomodoroWorkMinutes * 60;
          _isTimerRunning = false;
          break;
      }
      _isPaused = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorLightPrinciple,
      appBar: AppBar(
        backgroundColor: colorPrinciple.withOpacity(0.2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: colorWhite),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Watch',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: colorWhite,
          ),
        ),
        centerTitle: true,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.05),
      ),
      body: Column(
        children: [
          _buildTimerTypeSelector(),
          Expanded(
            child: Center(child: _buildTimer()),
          ),
          _buildBottomActions(),
        ],
      ),
    );
  }

  Widget _buildTimerTypeSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      color: colorLightPrinciple,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildTimerTypeButton(0, Icons.timer_outlined, "Countdown"),
              _buildTimerTypeButton(1, Icons.watch_later_outlined, "Stopwatch"),
              _buildTimerTypeButton(2, Icons.panorama_fish_eye, "Pomodoro"),
            ],
          ),
          // Container(
          //   color: Colors.red,
          //   child: SizedBox(
          //     width: 28,
          //     height: 28,
          //     child: Image(image: AssetImage('assets/images/pomodoro.png')),
          //   ),
          // ),

          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailTaskScreen()));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.edit_note, color: colorWhite, size: 30,),
                Text('Edit Task', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colorWhite),)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimerTypeButton(int index, IconData icon, String label) {
    final isSelected = _selectedTimerType == index;
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: () {
          if (_isDisposed) return;

          setState(() {
            if (_selectedTimerType != index) {
              _selectedTimerType = index;
              _isTimerRunning = false;
              _isPaused = false;
              _resetTimer();
            }
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: colorWhite,
              size: 28,
            ),
            const SizedBox(height: 4),
            Container(
              height: 2,
              width: 40,
              color: isSelected ? colorWhite : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTimer() {
    switch (_selectedTimerType) {
      case 0:
        return _buildCountdownTimer();
      case 1:
        return _buildStopwatchTimer();
      case 2:
        return _buildPomodoroTimer();
      default:
        return _buildCountdownTimer();
    }
  }

  Widget _buildCountdownTimer() {
    return Container(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 16),
                child: CircularCountDownTimer(
                  duration: 9132, // 2 hours 32 minutes 12 seconds
                  initialDuration: 0,
                  controller: _countDownController,
                  width: MediaQuery.of(context).size.width*3/4,
                  height:MediaQuery.of(context).size.width*3/4 ,
                  ringColor: colorPrinciple.withOpacity(0.2),
                  fillColor: colorWhite,
                  backgroundColor: colorLightPrinciple,
                  strokeWidth: 15.0,
                  strokeCap: StrokeCap.round,
                  textStyle: const TextStyle(
                    fontSize: 45,
                    color: colorWhite,
                    fontWeight: FontWeight.normal,
                  ),
                  textFormat: CountdownTextFormat.HH_MM_SS,
                  isReverse: true,
                  isReverseAnimation: false,
                  isTimerTextShown: true,
                  autoStart: false,
                  onComplete: onComplete,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: const Text(
                  'Total 3 hrs 35 mins',
                  style: TextStyle(
                    color: colorWhite,
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStopwatchTimer() {
    return Container(
      color: colorLightPrinciple,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*3/4,
                    height:MediaQuery.of(context).size.width*3/4 ,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorWhite,
                        width: 15,
                      ),
                    ),
                  ),
                  Text(
                    _stopwatchDisplay,
                    style: const TextStyle(
                      fontSize: 45,
                      color: colorWhite,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: const Text(
                  'Maximum 3 hrs 25 mins',
                  style: TextStyle(
                    color: colorWhite,
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPomodoroTimer() {
    return Container(
      color: colorLightPrinciple,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              CircularCountDownTimer(
                duration: _pomodoroTotalSeconds,
                initialDuration: 0,
                controller: _pomodoroController,
                width: MediaQuery.of(context).size.width*3/4,
                height:MediaQuery.of(context).size.width*3/4 ,
                ringColor: colorPrinciple.withOpacity(0.2),
                fillColor: colorWhite,
                backgroundColor: colorLightPrinciple,
                strokeWidth: 15.0,
                strokeCap: StrokeCap.round,
                textStyle: const TextStyle(
                  fontSize: 45,
                  color: colorWhite,
                  fontWeight: FontWeight.normal,
                ),
                textFormat: CountdownTextFormat.MM_SS,
                isReverse: true,
                isReverseAnimation: false,
                isTimerTextShown: true,
                autoStart: false,
                onComplete: _pomodoroFinished,
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: Text(
                  _isWorkTime
                      ? 'Working Time (Session $_pomodoroSession/$_maxPomodoroSessions)'
                      : 'Break Time',
                  style: const TextStyle(
                    color: colorWhite,
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextButton.icon(
                onPressed: () {
                  _showPomodoroSettingsBottomSheet();
                },
                icon: const Icon(
                  Icons.settings,
                  color: colorWhite,
                  size: 16,
                ),
                label: const Text(
                  "Settings",
                  style: TextStyle(
                    color: colorWhite,
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: colorPrinciple.withOpacity(0.3),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      color: colorLightPrinciple,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(
              Icons.stop_rounded,
              color: colorWhite,
              size: 28,
            ),
            onPressed: _isTimerRunning || _isPaused ? _stopTimer : null,
          ),
          const SizedBox(width: 40),
          CircleAvatar(
            radius: 30,
            backgroundColor: colorWhite,
            child: IconButton(
              icon: Icon(
                _isTimerRunning ? Icons.pause : Icons.play_arrow,
                color: colorBlack,
                size: 38,
              ),
              onPressed: _startStopTimer,
            ),
          ),
          const SizedBox(width: 40),
          IconButton(
            icon: const Icon(
              Icons.list_alt_outlined,
              color: colorWhite,
              size: 28,
            ),
            onPressed: () {
              _showTimeSheetBottomSheet();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, {required Function() onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: colorWhite,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'Inter',
              color: colorWhite,
            ),
          ),
        ],
      ),
    );
  }

  void _showPomodoroSettingsBottomSheet() {
    if (_isDisposed) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: const BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(top: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Pomodoro Settings',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: colorBlack,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            if (_isDisposed) return;

                            setState(() {
                              _pomodoroTotalSeconds = _pomodoroWorkMinutes * 60;
                              // Create a new controller instead of restarting the existing one
                              _pomodoroController = CountDownController();
                              _isWorkTime = true;
                              _pomodoroSession = 1;
                              _isTimerRunning = false;
                              _isPaused = false;
                            });
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: colorPrinciple,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(thickness: 1),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        _buildPomodoroSettingItem(
                          title: 'Work Time (minutes)',
                          value: _pomodoroWorkMinutes,
                          onChanged: (value) {
                            setModalState(() {
                              _pomodoroWorkMinutes = value;
                            });
                          },
                          min: 1,
                          max: 60,
                        ),
                        const SizedBox(height: 16),
                        _buildPomodoroSettingItem(
                          title: 'Short Break (minutes)',
                          value: _pomodoroBreakMinutes,
                          onChanged: (value) {
                            setModalState(() {
                              _pomodoroBreakMinutes = value;
                            });
                          },
                          min: 1,
                          max: 30,
                        ),
                        const SizedBox(height: 16),
                        _buildPomodoroSettingItem(
                          title: 'Long Break (minutes)',
                          value: _pomodoroLongBreakMinutes,
                          onChanged: (value) {
                            setModalState(() {
                              _pomodoroLongBreakMinutes = value;
                            });
                          },
                          min: 1,
                          max: 60,
                        ),
                        const SizedBox(height: 16),
                        _buildPomodoroSettingItem(
                          title: 'Number of Sessions',
                          value: _maxPomodoroSessions,
                          onChanged: (value) {
                            setModalState(() {
                              _maxPomodoroSessions = value;
                            });
                          },
                          min: 1,
                          max: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPomodoroSettingItem({
    required String title,
    required int value,
    required Function(int) onChanged,
    required int min,
    required int max,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: colorBlack,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: value > min
                  ? () => onChanged(value - 1)
                  : null,
              color: colorPrinciple,
            ),
            Expanded(
              child: Slider(
                value: value.toDouble(),
                min: min.toDouble(),
                max: max.toDouble(),
                divisions: max - min,
                activeColor: colorPrinciple,
                inactiveColor: colorPrinciple.withOpacity(0.2),
                onChanged: (double newValue) {
                  onChanged(newValue.round());
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: value < max
                  ? () => onChanged(value + 1)
                  : null,
              color: colorPrinciple,
            ),
            Container(
              width: 50,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                value.toString(),
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showTimeSheetBottomSheet() {
    if (_isDisposed) return;

    // Calculate total minutes
    int totalMinutes = _timesheetEntries.fold(0, (sum, entry) => sum + entry['minutes'] as int);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height* 0.7,
          decoration: const BoxDecoration(
            color: colorWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Header
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'TIME SHEET ($totalMinutes/180 min)',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: colorBlack,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showCreateTimeSheetBottomSheet();
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: colorPrinciple),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: colorPrinciple,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 2),
              // Entries
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: _timesheetEntries.length,
                  itemBuilder: (context, index) {
                    final entry = _timesheetEntries[index];
                    return _buildTimesheetEntry(
                      description: entry['description'],
                      minutes: entry['minutes'],
                      type: entry['type'],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCreateTimeSheetBottomSheet() {
    if (_isDisposed) return;

    final TextEditingController descriptionController = TextEditingController();
    TimeOfDay startTime = TimeOfDay.now();
    TimeOfDay endTime = TimeOfDay.now().replacing(
        hour: (TimeOfDay.now().hour + 1) % 24
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height / 2,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Create A TimeSheet',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_isDisposed) return;

                          // Calculate minutes between start and end time
                          int startMinutes = startTime.hour * 60 + startTime.minute;
                          int endMinutes = endTime.hour * 60 + endTime.minute;

                          int duration = endMinutes - startMinutes;
                          if (duration < 0) {
                            duration += 24 * 60; // Add a day if end time is on the next day
                          }

                          setState(() {
                            _timesheetEntries.add({
                              'description': descriptionController.text.isNotEmpty
                                  ? descriptionController.text
                                  : 'Task completed',
                              'minutes': duration,
                              'type': 'study',
                            });
                          });

                          Navigator.pop(context); // Close create sheet
                          Navigator.pop(context); // Close timesheet list
                          _showTimeSheetBottomSheet(); // Reopen with new entry
                        },
                        child: const Text(
                          'Add',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: colorPrinciple,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Time row
                  Row(
                    children: [
                      // Start time
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Start Time',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () async {
                                final TimeOfDay? picked = await showTimePicker(
                                  context: context,
                                  initialTime: startTime,
                                );
                                if (picked != null) {
                                  setModalState(() {
                                    startTime = picked;
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.black.withOpacity(0.2),
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      startTime.format(context),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black.withOpacity(0.7),
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      size: 18,
                                      color: Colors.black.withOpacity(0.7),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      // End time
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'End Time',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () async {
                                final TimeOfDay? picked = await showTimePicker(
                                  context: context,
                                  initialTime: endTime,
                                );
                                if (picked != null) {
                                  setModalState(() {
                                    endTime = picked;
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.black.withOpacity(0.2),
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      endTime.format(context),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black.withOpacity(0.7),
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      size: 18,
                                      color: Colors.black.withOpacity(0.7),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black.withOpacity(0.2),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          hintText: 'Take notes on what you did during this time.',
                          hintStyle: TextStyle(
                            color: Colors.black54,
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          border: InputBorder.none,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTimesheetEntry({
    required String description,
    required int minutes,
    required String type,
  }) {
    // Define colors based on type
    Color bgColor;
    Color iconColor;

    switch (type) {
      case 'study':
        bgColor = const Color(0x332196F3); // Light blue background
        iconColor = const Color(0xFF2196F3); // Blue icon
        break;
      case 'break':
        bgColor = const Color(0x33DC3E73); // Light pink background
        iconColor = const Color(0xFFDC3E73); // Pink icon
        break;
      case 'focus':
        bgColor = const Color(0x334CB050); // Light green background
        iconColor = const Color(0xFF4CB050); // Green icon
        break;
      default:
        bgColor = const Color(0x332196F3);
        iconColor = const Color(0xFF2196F3);
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.timer,
                      size: 14,
                      color: iconColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '+ $minutes min',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                  color: colorBlack,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'Inter',
              color: colorGrey,
            ),
          ),
        ],
      ),
    );
  }

  void onComplete() {
    if (_isDisposed) return;

    setState(() {
      _isTimerRunning = false;
      _isPaused = false;
    });

    _showTaskSuccessDialog("Hoàn thành!", "Bạn đã hoàn thành thời gian đếm ngược. Nhấn 'Lưu' để lưu lại thông tin.");
  }

  void _showTaskSuccessDialog(String title, String message) {
    if (_isDisposed) return;

    String taskDescription = '';

    TaskSuccessDialog.show(
      context: context,
      title: title,
      message: message,
      onSubmit: () {
        Navigator.of(context).pop();

        // Add entry to timesheet with proper duration calculation
        int minutes = 0;

        if (_selectedTimerType == 0) { // countdown
          // Calculate minutes from countdown
          minutes = 10; // Placeholder - actual calculation would depend on your specific implementation
        } else if (_selectedTimerType == 1) { // stopwatch
          // Calculate minutes from stopwatch
          minutes = _stopwatch.elapsed.inMinutes;
          _stopwatch.reset();
          _stopwatchDisplay = "00:00:00";
        } else if (_selectedTimerType == 2) { // pomodoro
          // Calculate minutes from pomodoro
          int sessionsCompleted = _pomodoroSession - 1; // Since we increment before check
          minutes = sessionsCompleted * _pomodoroWorkMinutes;
        }

        setState(() {
          _timesheetEntries.add({
            'description': taskDescription.isNotEmpty
                ? taskDescription
                : 'Task completed',
            'minutes': minutes,
            'type': 'study',
          });
        });
      },
      onCancel: () {
        Navigator.of(context).pop();
      },
      onDescriptionSaved: (description) {
        taskDescription = description;
      },
    );
  }

  void _showWarningDialog(String title, String message) {
    if (_isDisposed) return;

    String taskDescription = '';

    WarningDialog.show(
      context: context,
      title: title,
      message: message,
      onSubmit: () {
        Navigator.of(context).pop();

        // Add entry to timesheet with proper duration calculation
        int minutes = 0;

        if (_selectedTimerType == 0) { // countdown
          // Calculate minutes from countdown
          minutes = 10; // Placeholder - actual calculation would depend on your specific implementation
        } else if (_selectedTimerType == 1) { // stopwatch
          // Calculate minutes from stopwatch
          minutes = _stopwatch.elapsed.inMinutes;
          _stopwatch.reset();
          _stopwatchDisplay = "00:00:00";
        } else if (_selectedTimerType == 2) { // pomodoro
          // Calculate minutes from pomodoro
          int sessionsCompleted = _pomodoroSession - 1; // Since we increment before check
          minutes = sessionsCompleted * _pomodoroWorkMinutes;
        }

        setState(() {
          _timesheetEntries.add({
            'description': taskDescription.isNotEmpty
                ? taskDescription
                : 'Task stopped',
            'minutes': minutes,
            'type': 'focus',
          });
        });
      },
      onCancel: () {
        Navigator.of(context).pop();
      },
      onDescriptionSaved: (description) {
        taskDescription = description;
      },
    );
  }
}