package com.example.SHRMS.service;

import com.example.SHRMS.model.Task;
import com.example.SHRMS.repository.TaskRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Slf4j
public class TaskService {

    private final TaskRepository taskRepository;

    public List<Task> getTasksForEmployee(Long employeeId) {
        return taskRepository.findByAssignedTo_EmployeeIdOrderByDeadlineAsc(employeeId);
    }

    public List<Task> getTasksAssignedBy(Long managerId) {
        return taskRepository.findByAssignedBy_EmployeeIdOrderByDeadlineAsc(managerId);
    }

    public List<Task> getTasksForManagerTeam(Long managerId) {
        return taskRepository.findByManagerId(managerId);
    }

    public List<Task> getAllTasks() {
        return taskRepository.findAll();
    }

    public Optional<Task> findById(Long id) {
        return taskRepository.findById(id);
    }

    @Transactional
    public Task saveTask(Task task) {
        if (task.getTaskId() == null) {
            task.setStatus("TODO");
        }
        return taskRepository.save(task);
    }

    @Transactional
    public Task updateStatus(Long taskId, String status) {
        Task task = taskRepository.findById(taskId)
                .orElseThrow(() -> new RuntimeException("Task not found"));
        task.setStatus(status);
        return taskRepository.save(task);
    }

    @Transactional
    public void deleteTask(Long id) {
        taskRepository.deleteById(id);
    }

    public long countByEmployeeAndStatus(Long empId, String status) {
        return taskRepository.countByAssignedTo_EmployeeIdAndStatus(empId, status);
    }
}
