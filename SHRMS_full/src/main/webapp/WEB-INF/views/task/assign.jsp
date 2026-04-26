<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Assign Task — Smart HRMS</title>
  <%@ include file="/WEB-INF/views/common/head.jsp" %>
</head>
<body>
<div class="wrapper">
  <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
  <div class="main-content">
    <c:set var="pageTitle" value="Assign Task" />
    <%@ include file="/WEB-INF/views/common/topbar.jsp" %>
    <div class="page-body fade-in">
      <%@ include file="/WEB-INF/views/common/alerts.jsp" %>
      <div class="row justify-content-center">
        <div class="col-lg-7">
          <div class="card">
            <div class="card-header">
              <h5><i class="bi bi-plus-square-fill text-primary me-2"></i>Assign New Task</h5>
              <a href="${pageContext.request.contextPath}/tasks" class="btn btn-outline btn-sm"><i class="bi bi-arrow-left"></i> Back</a>
            </div>
            <div class="card-body">
              <form action="${pageContext.request.contextPath}/tasks/assign" method="post">
                <div class="row g-3">
                  <div class="col-12">
                    <div class="form-group">
                      <label class="form-label">Task Title *</label>
                      <input type="text" name="title" class="form-control" placeholder="Enter task title" required>
                    </div>
                  </div>
                  <div class="col-12">
                    <div class="form-group">
                      <label class="form-label">Description</label>
                      <textarea name="description" class="form-control" rows="3" placeholder="Describe the task in detail..."></textarea>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="form-group">
                      <label class="form-label">Assign To *</label>
                      <select name="assignedTo" class="form-select" required>
                        <option value="">Select Employee</option>
                        <c:forEach var="emp" items="${employees}">
                          <option value="${emp.employeeId}">${emp.firstName} ${emp.lastName} — ${emp.department.departmentName}</option>
                        </c:forEach>
                      </select>
                    </div>
                  </div>
                  <div class="col-md-3">
                    <div class="form-group">
                      <label class="form-label">Priority *</label>
                      <select name="priority" class="form-select" required>
                        <option value="">Priority</option>
                        <option value="LOW">🟢 Low</option>
                        <option value="MEDIUM">🟡 Medium</option>
                        <option value="HIGH">🔴 High</option>
                      </select>
                    </div>
                  </div>
                  <div class="col-md-3">
                    <div class="form-group">
                      <label class="form-label">Deadline *</label>
                      <input type="date" name="deadline" class="form-control" required>
                    </div>
                  </div>
                </div>
                <div class="d-flex justify-content-end gap-2 mt-4">
                  <a href="${pageContext.request.contextPath}/tasks" class="btn btn-outline">Cancel</a>
                  <button type="submit" class="btn btn-primary"><i class="bi bi-send"></i> Assign Task</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
