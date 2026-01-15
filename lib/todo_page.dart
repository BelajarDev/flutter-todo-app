import 'package:flutter/material.dart';
import 'todo_model.dart';

class TodoPage extends StatefulWidget {
  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final List<Todo> todos = [];
  final TextEditingController controller = TextEditingController();
  int _selectedFilter = 0; // 0: All, 1: Active, 2: Completed
  final List<String> filters = ['Semua', 'Aktif', 'Selesai'];

  void addTodo() {
    if (controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Masukkan todo terlebih dahulu'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      todos.add(Todo(title: controller.text.trim(), createdAt: DateTime.now()));
      controller.clear();
    });

    // Sembunyikan keyboard
    FocusScope.of(context).unfocus();
  }

  void toggleTodo(int index) {
    setState(() {
      todos[index].isDone = !todos[index].isDone;
      todos[index].completedAt = todos[index].isDone ? DateTime.now() : null;
    });
  }

  void deleteTodo(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Hapus Todo'),
        content: Text(
          'Apakah Anda yakin ingin menghapus "${todos[index].title}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal', style: TextStyle(color: Colors.grey.shade700)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                todos.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Todo berhasil dihapus'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
            ),
            child: Text('Hapus', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void clearCompleted() {
    if (todos.where((todo) => todo.isDone).isEmpty) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Hapus Selesai'),
        content: Text('Hapus semua todo yang sudah selesai?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal', style: TextStyle(color: Colors.grey.shade700)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                todos.removeWhere((todo) => todo.isDone);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Todo selesai berhasil dihapus'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
            ),
            child: Text('Hapus', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  List<Todo> get filteredTodos {
    switch (_selectedFilter) {
      case 1:
        return todos.where((todo) => !todo.isDone).toList();
      case 2:
        return todos.where((todo) => todo.isDone).toList();
      default:
        return todos;
    }
  }

  int get activeCount => todos.where((todo) => !todo.isDone).length;
  int get completedCount => todos.where((todo) => todo.isDone).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text(
          'To-Do List',
          style: TextStyle(
            color: Colors.grey.shade800,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        actions: [
          if (completedCount > 0)
            IconButton(
              icon: Icon(
                Icons.delete_sweep_outlined,
                color: Colors.red.shade600,
              ),
              onPressed: clearCompleted,
              tooltip: 'Hapus yang selesai',
            ),
        ],
      ),
      body: Column(
        children: [
          // Header Stats
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  'Total',
                  todos.length.toString(),
                  Icons.list_alt,
                  Colors.blue.shade700,
                ),
                _buildStatItem(
                  'Aktif',
                  activeCount.toString(),
                  Icons.access_time,
                  Colors.orange.shade600,
                ),
                _buildStatItem(
                  'Selesai',
                  completedCount.toString(),
                  Icons.check_circle,
                  Colors.green.shade600,
                ),
              ],
            ),
          ),

          // Filter Chips
          Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                filters.length,
                (index) => FilterChip(
                  label: Text(filters[index]),
                  selected: _selectedFilter == index,
                  onSelected: (selected) {
                    setState(() {
                      _selectedFilter = index;
                    });
                  },
                  selectedColor: Colors.blue.shade100,
                  checkmarkColor: Colors.blue.shade700,
                  backgroundColor: Colors.grey.shade100,
                  labelStyle: TextStyle(
                    color: _selectedFilter == index
                        ? Colors.blue.shade700
                        : Colors.grey.shade700,
                    fontWeight: _selectedFilter == index
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 8),

          // Input Todo
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Apa yang ingin Anda lakukan?',
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                        ),
                        onSubmitted: (_) => addTodo(),
                      ),
                    ),
                    IconButton(
                      onPressed: addTodo,
                      icon: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade700,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.add, color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 8),

          // List Todo
          Expanded(
            child: filteredTodos.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _selectedFilter == 1
                              ? Icons.access_time
                              : _selectedFilter == 2
                              ? Icons.check_circle
                              : Icons.list_alt,
                          size: 80,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(height: 16),
                        Text(
                          _selectedFilter == 1
                              ? 'Tidak ada todo aktif'
                              : _selectedFilter == 2
                              ? 'Tidak ada todo selesai'
                              : 'Belum ada todo',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          _selectedFilter == 0
                              ? 'Tambahkan todo pertama Anda!'
                              : _selectedFilter == 1
                              ? 'Semua todo sudah selesai!'
                              : 'Selesaikan beberapa todo!',
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: filteredTodos.length,
                    itemBuilder: (context, index) {
                      final todo = filteredTodos[index];
                      return Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red.shade600,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        confirmDismiss: (direction) async {
                          return await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Hapus Todo'),
                              content: Text(
                                'Apakah Anda yakin ingin menghapus "${todo.title}"?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: Text('Batal'),
                                ),
                                ElevatedButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red.shade600,
                                  ),
                                  child: Text('Hapus'),
                                ),
                              ],
                            ),
                          );
                        },
                        onDismissed: (direction) {
                          final originalIndex = todos.indexOf(todo);
                          deleteTodo(originalIndex);
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: GestureDetector(
                              onTap: () {
                                final originalIndex = todos.indexOf(todo);
                                toggleTodo(originalIndex);
                              },
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: todo.isDone
                                        ? Colors.green.shade600
                                        : Colors.grey.shade400,
                                    width: 2,
                                  ),
                                  color: todo.isDone
                                      ? Colors.green.shade600
                                      : Colors.transparent,
                                ),
                                child: todo.isDone
                                    ? Icon(
                                        Icons.check,
                                        size: 16,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                            ),
                            title: Text(
                              todo.title,
                              style: TextStyle(
                                fontSize: 16,
                                decoration: todo.isDone
                                    ? TextDecoration.lineThrough
                                    : null,
                                color: todo.isDone
                                    ? Colors.grey.shade500
                                    : Colors.grey.shade800,
                                fontWeight: todo.isDone
                                    ? FontWeight.normal
                                    : FontWeight.w500,
                              ),
                            ),
                            subtitle: todo.createdAt != null
                                ? Text(
                                    'Dibuat: ${_formatDate(todo.createdAt!)}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade500,
                                    ),
                                  )
                                : null,
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (todo.isDone && todo.completedAt != null)
                                  Text(
                                    _formatDate(todo.completedAt!),
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.green.shade600,
                                    ),
                                  ),
                                SizedBox(width: 8),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete_outline,
                                    color: Colors.red.shade400,
                                  ),
                                  onPressed: () {
                                    final originalIndex = todos.indexOf(todo);
                                    deleteTodo(originalIndex);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),

          // Footer
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$activeCount item aktif',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                if (todos.isNotEmpty)
                  Text(
                    'Total: ${todos.length} todo',
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final dateDay = DateTime(date.year, date.month, date.day);

    if (dateDay == today) {
      return 'Hari ini ${_formatTime(date)}';
    } else if (dateDay == yesterday) {
      return 'Kemarin ${_formatTime(date)}';
    } else {
      return '${date.day}/${date.month}/${date.year} ${_formatTime(date)}';
    }
  }

  String _formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
