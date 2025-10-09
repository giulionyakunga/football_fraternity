import 'package:flutter/material.dart';
import 'package:football_fraternity/models/appointment.dart';
import 'package:football_fraternity/widgets/appointment_card.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';
import 'package:football_fraternity/utils/responsive.dart';

class AppointmentsListScreen extends StatelessWidget {
  AppointmentsListScreen({super.key});

  final List<Appointment> appointments = [
    Appointment(
      id: '1',
      title: 'Contract Review Meeting',
      description: 'Review new contract offer from KMC FC including salary terms and bonus structure',
      date: DateTime(2023, 7, 15),
      time: '10:00 AM',
      status: 'Confirmed',
      legalOfficerId: '1',
      legalOfficerName: 'Sarah Johnson',
      clientId: '1',
      clientName: 'Kibu Denis',
      duration: 60,
      location: 'Main Office - Conference Room A',
    ),
    Appointment(
      id: '2',
      title: 'Transfer Discussion Session',
      description: 'Discuss potential transfer terms and negotiations with Yanga FC representatives',
      date: DateTime(2023, 7, 20),
      time: '2:30 PM',
      status: 'Pending',
      legalOfficerId: '1',
      legalOfficerName: 'Sarah Johnson',
      clientId: '2',
      clientName: 'Yazid Alpha',
      duration: 90,
      location: 'Virtual Meeting',
    ),
    Appointment(
      id: '3',
      title: 'Legal Consultation',
      description: 'Initial consultation regarding image rights protection and commercial agreements',
      date: DateTime(2023, 7, 18),
      time: '11:00 AM',
      status: 'Confirmed',
      legalOfficerId: '2',
      legalOfficerName: 'Michael Brown',
      clientId: '3',
      clientName: 'John Bocco',
      duration: 45,
      location: 'Main Office - Room 205',
    ),
    Appointment(
      id: '4',
      title: 'Contract Signing',
      description: 'Final contract signing ceremony with club representatives and legal team',
      date: DateTime(2023, 7, 22),
      time: '3:00 PM',
      status: 'Confirmed',
      legalOfficerId: '3',
      legalOfficerName: 'Emily Davis',
      clientId: '4',
      clientName: 'Mbwana Samatta',
      duration: 30,
      location: 'Club Headquarters',
    ),
    Appointment(
      id: '5',
      title: 'Dispute Resolution Meeting',
      description: 'Mediation session for contract dispute resolution with previous club management',
      date: DateTime(2023, 7, 25),
      time: '9:30 AM',
      status: 'Pending',
      legalOfficerId: '1',
      legalOfficerName: 'Sarah Johnson',
      clientId: '5',
      clientName: 'Thomas Ulimwengu',
      duration: 120,
      location: 'Mediation Center',
    ),
    Appointment(
      id: '6',
      title: 'Career Planning Session',
      description: 'Strategic career planning and future contract opportunities discussion',
      date: DateTime(2023, 7, 28),
      time: '1:00 PM',
      status: 'Cancelled',
      legalOfficerId: '2',
      legalOfficerName: 'Michael Brown',
      clientId: '6',
      clientName: 'David Mwantika',
      duration: 60,
      location: 'Main Office - Room 301',
    ),
  ];

  Widget _buildDesktopLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Appointments Management',
                    style: AppStyles.heading1.copyWith(
                      fontSize: 36,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Manage your legal appointments and meetings',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              _buildStatsOverview(),
            ],
          ),
          const SizedBox(height: 40),

          // Calendar and Controls Section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Calendar Section
              Expanded(
                flex: 1,
                child: _buildCalendarSection(context),
              ),
              const SizedBox(width: 30),

              // Appointments List
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildControlsSection(context),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: appointments.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: AppointmentCard(appointment: appointments[index]),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isTablet(context) ? 30 : 20,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Text(
            'My Appointments',
            style: AppStyles.heading1.copyWith(
              fontSize: Responsive.isTablet(context) ? 28 : 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Manage your legal appointments and meetings',
            style: TextStyle(
              fontSize: Responsive.isTablet(context) ? 16 : 14,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 20),

          // Mobile Stats
          _buildMobileStats(),
          const SizedBox(height: 20),

          // Calendar Section
          _buildCalendarSection(context),
          const SizedBox(height: 20),

          // Controls Section
          _buildControlsSection(context),
          const SizedBox(height: 20),

          // Appointments List
          Expanded(
            child: ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: AppointmentCard(appointment: appointments[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarSection(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'July 2023',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.chevron_left, color: Colors.grey[600]),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.chevron_right, color: Colors.grey[600]),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Simplified calendar view
            Container(
              height: Responsive.isDesktop(context) ? 200 : 150,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemCount: 42, // 6 weeks
                itemBuilder: (context, index) {
                  final day = index - 2; // Adjust for starting day
                  final hasAppointment = day == 15 || day == 18 || day == 20 || day == 22 || day == 25;
                  
                  return Container(
                    decoration: BoxDecoration(
                      color: hasAppointment ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: hasAppointment ? AppColors.primary : Colors.transparent,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        day > 0 && day <= 31 ? day.toString() : '',
                        style: TextStyle(
                          fontWeight: hasAppointment ? FontWeight.bold : FontWeight.normal,
                          color: hasAppointment ? AppColors.primary : Colors.grey[700],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                // Show full calendar
              },
              icon: const Icon(Icons.calendar_today, size: 18),
              label: const Text('View Full Calendar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsOverview() {
    final confirmedCount = appointments.where((a) => a.status == 'Confirmed').length;
    final pendingCount = appointments.where((a) => a.status == 'Pending').length;
    final cancelledCount = appointments.where((a) => a.status == 'Cancelled').length;
    final todayCount = appointments.where((a) => a.date.day == DateTime.now().day).length;

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            _buildStatItem(appointments.length.toString(), 'Total', Icons.calendar_today),
            const SizedBox(width: 20),
            _buildStatItem(confirmedCount.toString(), 'Confirmed', Icons.check_circle, Colors.green),
            const SizedBox(width: 20),
            _buildStatItem(pendingCount.toString(), 'Pending', Icons.pending, Colors.orange),
            const SizedBox(width: 20),
            _buildStatItem(todayCount.toString(), 'Today', Icons.today, Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileStats() {
    final confirmedCount = appointments.where((a) => a.status == 'Confirmed').length;
    final pendingCount = appointments.where((a) => a.status == 'Pending').length;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem(appointments.length.toString(), 'Total', Icons.calendar_today),
            _buildStatItem(confirmedCount.toString(), 'Confirmed', Icons.check_circle, Colors.green),
            _buildStatItem(pendingCount.toString(), 'Pending', Icons.pending, Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon, [Color? color]) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (color ?? AppColors.primary).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: color ?? AppColors.primary),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color ?? Colors.black87,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildControlsSection(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // Search Field
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search appointments...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Filter Button
            PopupMenuButton<String>(
              icon: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.filter_list, color: Colors.white, size: 20),
              ),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'all',
                  child: Row(
                    children: [
                      Icon(Icons.all_inclusive, size: 20),
                      SizedBox(width: 8),
                      Text('All Appointments'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'confirmed',
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 20),
                      SizedBox(width: 8),
                      Text('Confirmed'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'pending',
                  child: Row(
                    children: [
                      Icon(Icons.pending, color: Colors.orange, size: 20),
                      SizedBox(width: 8),
                      Text('Pending'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'cancelled',
                  child: Row(
                    children: [
                      Icon(Icons.cancel, color: Colors.red, size: 20),
                      SizedBox(width: 8),
                      Text('Cancelled'),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem(
                  value: 'today',
                  child: Row(
                    children: [
                      Icon(Icons.today, size: 20),
                      SizedBox(width: 8),
                      Text('Today'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'week',
                  child: Row(
                    children: [
                      Icon(Icons.calendar_view_week, size: 20),
                      SizedBox(width: 8),
                      Text('This Week'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'month',
                  child: Row(
                    children: [
                      Icon(Icons.calendar_view_month, size: 20),
                      SizedBox(width: 8),
                      Text('This Month'),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(width: 12),

            // Sort Button
            PopupMenuButton<String>(
              icon: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.sort, color: Colors.black54, size: 20),
              ),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'date',
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, size: 20),
                      SizedBox(width: 8),
                      Text('Sort by Date'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'time',
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 20),
                      SizedBox(width: 8),
                      Text('Sort by Time'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'status',
                  child: Row(
                    children: [
                      Icon(Icons.info, size: 20),
                      SizedBox(width: 8),
                      Text('Sort by Status'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'client',
                  child: Row(
                    children: [
                      Icon(Icons.person, size: 20),
                      SizedBox(width: 8),
                      Text('Sort by Client'),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(width: 12),

            // New Appointment Button (Desktop)
            if (Responsive.isDesktop(context))
              ElevatedButton.icon(
                onPressed: () {
                  // Navigator.pushNamed(context, '/appointments/form');
                },
                icon: const Icon(Icons.add, size: 20),
                label: const Text('New Appointment'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        // Navigator.pushNamed(context, '/appointments/form');
      },
      backgroundColor: AppColors.primary,
      elevation: 4,
      child: const Icon(Icons.add, color: Colors.white, size: 28),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Appointments',
          style: TextStyle(
            fontSize: Responsive.isDesktop(context) ? 20 : 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: !Responsive.isDesktop(context),
        actions: [
          if (!Responsive.isDesktop(context))
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                // Navigator.pushNamed(context, '/appointments/form');
              },
              tooltip: 'New Appointment',
            ),
        ],
      ),
      body: Responsive.isDesktop(context) 
          ? _buildDesktopLayout(context)
          : _buildMobileLayout(context),
      floatingActionButton: Responsive.isDesktop(context) ? null : _buildFloatingActionButton(),
    );
  }
}