import 'package:flutter/material.dart';

void main() {
  runApp(const SwiftModApp());
}

class SwiftModApp extends StatelessWidget {
  const SwiftModApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swift Mod',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD0BCFF),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const AppLayout(),
        '/analysis': (context) => const AnalysisScreen(),
        '/patch_center': (context) => const PatchCenterScreen(),
        '/ai_assistant': (context) => const AiAssistantScreen(),
        '/export': (context) => const ExportScreen(),
      },
    );
  }
}

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const AppLibraryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isWideScreen = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Swift Mod'),
        actions: [
          IconButton(
            icon: const Icon(Icons.smart_toy),
            tooltip: 'AI Assistant',
            onPressed: () => Navigator.pushNamed(context, '/ai_assistant'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {},
          ),
        ],
      ),
      body: Row(
        children: [
          if (isWideScreen)
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  selectedIcon: Icon(Icons.dashboard),
                  label: Text('Dashboard'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.apps_outlined),
                  selectedIcon: Icon(Icons.apps),
                  label: Text('Library'),
                ),
              ],
            ),
          if (isWideScreen) const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ],
      ),
      bottomNavigationBar: isWideScreen
          ? null
          : NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  selectedIcon: Icon(Icons.dashboard),
                  label: 'Dashboard',
                ),
                NavigationDestination(
                  icon: Icon(Icons.apps_outlined),
                  selectedIcon: Icon(Icons.apps),
                  label: 'Library',
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Import APK flow
        },
        child: const Icon(Icons.add),
        tooltip: 'Import APK',
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text(
          'Overview',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
            return GridView.count(
              crossAxisCount: crossAxisCount,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2.5,
              children: const [
                _StatCard(title: 'Projects', value: '4', icon: Icons.folder),
                _StatCard(title: 'Analyses', value: '12', icon: Icons.analytics),
                _StatCard(title: 'Patches Applied', value: '28', icon: Icons.build),
                _StatCard(title: 'Storage Used', value: '1.2 GB', icon: Icons.storage),
              ],
            );
          },
        ),
        const SizedBox(height: 32),
        Text(
          'Recent Projects',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Card(
          child: ListTile(
            leading: const Icon(Icons.android, size: 40),
            title: const Text('Example App (com.example.app)'),
            subtitle: const Text('Modified: Ad removal, Network block'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, '/analysis'),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({required this.title, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 48, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AppLibraryScreen extends StatelessWidget {
  const AppLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              child: Text('A${index + 1}'),
            ),
            title: Text('App Name ${index + 1}'),
            subtitle: Text('v1.0.${index} • com.example.app${index}'),
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'analyze', child: Text('Analyze')),
                const PopupMenuItem(value: 'patch', child: Text('Patch Center')),
                const PopupMenuItem(value: 'export', child: Text('Export')),
              ],
              onSelected: (value) {
                if (value == 'analyze') Navigator.pushNamed(context, '/analysis');
                if (value == 'patch') Navigator.pushNamed(context, '/patch_center');
                if (value == 'export') Navigator.pushNamed(context, '/export');
              },
            ),
            onTap: () => Navigator.pushNamed(context, '/analysis'),
          ),
        );
      },
    );
  }
}

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analysis Report'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const ListTile(
            title: Text('Google Dependencies'),
            subtitle: Text('Found Google Play Services, Google Analytics'),
            leading: Icon(Icons.warning, color: Colors.orange),
          ),
          const Divider(),
          const ListTile(
            title: Text('Network Activity'),
            subtitle: Text('3 telemetry endpoints detected'),
            leading: Icon(Icons.network_wifi, color: Colors.red),
          ),
          const Divider(),
          const ListTile(
            title: Text('Permissions'),
            subtitle: Text('14 permissions requested (2 dangerous)'),
            leading: Icon(Icons.security, color: Colors.blue),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/patch_center'),
            icon: const Icon(Icons.build),
            label: const Text('Open Patch Center'),
          ),
        ],
      ),
    );
  }
}

class PatchCenterScreen extends StatelessWidget {
  const PatchCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patch Center'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            title: const Text('Remove Ad SDKs'),
            subtitle: const Text('Disables known advertisement networks'),
            value: true,
            onChanged: (val) {},
            secondary: const Icon(Icons.block),
          ),
          SwitchListTile(
            title: const Text('Disable Telemetry'),
            subtitle: const Text('Removes analytics and crash reporting'),
            value: true,
            onChanged: (val) {},
            secondary: const Icon(Icons.analytics),
          ),
          SwitchListTile(
            title: const Text('Block Internet Access'),
            subtitle: const Text('Removes INTERNET permission entirely'),
            value: false,
            onChanged: (val) {},
            secondary: const Icon(Icons.wifi_off),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () => Navigator.pushNamed(context, '/export'),
            child: const Text('Apply Patches & Export'),
          ),
        ],
      ),
    );
  }
}

class AiAssistantScreen extends StatelessWidget {
  const AiAssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Assistant'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 8, right: 40),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      'Hello! I can help you analyze this APK and suggest patches. What would you like to achieve?',
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 8, left: 40),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      'Make this application completely offline and remove all ads.',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Ask the AI...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ExportScreen extends StatelessWidget {
  const ExportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Export APK'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const ListTile(
            title: Text('Signing Method'),
            subtitle: Text('Default internal signing key (v1, v2, v3)'),
            leading: Icon(Icons.key),
          ),
          const Divider(),
          ListTile(
            title: const Text('Output Location'),
            subtitle: const Text('/storage/emulated/0/Download/SwiftMod/'),
            leading: const Icon(Icons.folder),
            trailing: TextButton(
              onPressed: () {},
              child: const Text('Change'),
            ),
          ),
          const SizedBox(height: 32),
          Center(
            child: FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Building and signing APK...')),
                );
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              icon: const Icon(Icons.save_alt),
              label: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Text('Export Patched APK'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
