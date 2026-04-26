<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Tasks — Smart HRMS</title>
  <%@ include file="/WEB-INF/views/common/head.jsp" %>
</head>
<body>
<div class="wrapper">
  <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
  <div class="main-content">
    <c:set var="pageTitle" value="Task Management" />
    <%@ include file="/WEB-INF/views/common/topbar.jsp" %>
    <div class="page-body fade-in">
      <%@ include file="/WEB-INF/views/common/alerts.jsp" %>

      <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
          <h5 class="fw-bold mb-0">Task Board</h5>
          <p class="text-muted small mb-0">${tasks.size()} total tasks</p>
        </div>
        <c:if test="${role == 'ADMIN' || role == 'HR' || role == 'MANAGER'}">
          <a href="${pageContext.request.contextPath}/tasks/assign" class="btn btn-primary">
            <i class="bi bi-plus-lg"></i> Assign Task
          </a>
        </c:if>
      </div>

      <!-- Kanban Board -->
      <div class="row g-3">

        <!-- TODO Column -->
        <div class="col-md-4">
          <div class="kanban-col">
            <div class="kanban-col-header">
              <span style="width:10px;height:10px;border-radius:50%;background:#94a3b8;display:inline-block;"></span>
              To Do
              <span class="badge badge-secondary ms-auto">
                <c:set var="todoC" value="0"/>
                <c:forEach var="t" items="${tasks}"><c:if test="${t.status == 'TODO'}"><c:set var="todoC" value="${todoC+1}"/></c:if></c:forEach>
                ${todoC}
              </span>
            </div>
            <c:forEach var="t" items="${tasks}">
              <c:if test="${t.status == 'TODO'}">
                <div class="task-card" style="position:relative;padding-left:16px;">
                  <div class="task-priority"
                       style="background:${t.priority == 'HIGH' ? '#ef4444' : t.priority == 'MEDIUM' ? '#f59e0b' : '#10b981'};"></div>
                  <div class="fw-600 small mb-1">${t.title}</div>
                  <div class="text-muted" style="font-size:11px;margin-bottom:8px;">${t.description}</div>
                  <div style="display:flex;justify-content:space-between;align-items:center;">
                    <span class="badge badge-secondary" style="font-size:10px;">${t.assignedTo.firstName}</span>
                    <span class="badge ${t.priority == 'HIGH' ? 'badge-danger' : t.priority == 'MEDIUM' ? 'badge-warning' : 'badge-success'}" style="font-size:10px;">${t.priority}</span>
                  </div>
                  <div class="text-muted" style="font-size:10px;margin-top:6px;">
                    <i class="bi bi-calendar3"></i> ${t.deadline}
                  </div>
                  <div class="d-flex gap-1 mt-2">
                    <form action="${pageContext.request.contextPath}/tasks/status/${t.taskId}" method="post">
                      <input type="hidden" name="status" value="IN_PROGRESS">
                      <button class="btn btn-outline btn-sm" style="font-size:10px;padding:2px 8px;">→ In Progress</button>
                    </form>
                    <c:if test="${role == 'ADMIN' || role == 'HR' || role == 'MANAGER'}">
                    <form action="${pageContext.request.contextPath}/tasks/delete/${t.taskId}" method="post" data-confirm="Delete this task?">
                      <button class="btn btn-ghost btn-sm" style="font-size:11px;color:var(--danger);padding:2px 6px;">
                        <i class="bi bi-trash"></i>
                      </button>
                    </form>
                    </c:if>
                  </div>
                </div>
              </c:if>
            </c:forEach>
          </div>
        </div>

        <!-- IN PROGRESS Column -->
        <div class="col-md-4">
          <div class="kanban-col" style="background:#fff9f0;">
            <div class="kanban-col-header">
              <span style="width:10px;height:10px;border-radius:50%;background:#f59e0b;display:inline-block;"></span>
              In Progress
              <span class="badge badge-warning ms-auto">
                <c:set var="ipC" value="0"/>
                <c:forEach var="t" items="${tasks}"><c:if test="${t.status == 'IN_PROGRESS'}"><c:set var="ipC" value="${ipC+1}"/></c:if></c:forEach>
                ${ipC}
              </span>
            </div>
            <c:forEach var="t" items="${tasks}">
              <c:if test="${t.status == 'IN_PROGRESS'}">
                <div class="task-card" style="position:relative;padding-left:16px;">
                  <div class="task-priority" style="background:#f59e0b;"></div>
                  <div class="fw-600 small mb-1">${t.title}</div>
                  <div class="text-muted" style="font-size:11px;margin-bottom:8px;">${t.description}</div>
                  <div style="display:flex;justify-content:space-between;align-items:center;">
                    <span class="badge badge-secondary" style="font-size:10px;">${t.assignedTo.firstName}</span>
                    <span class="badge ${t.priority == 'HIGH' ? 'badge-danger' : t.priority == 'MEDIUM' ? 'badge-warning' : 'badge-success'}" style="font-size:10px;">${t.priority}</span>
                  </div>
                  <div class="text-muted" style="font-size:10px;margin-top:6px;">
                    <i class="bi bi-calendar3"></i> ${t.deadline}
                  </div>
                  <div class="d-flex gap-1 mt-2">
                    <form action="${pageContext.request.contextPath}/tasks/status/${t.taskId}" method="post">
                      <input type="hidden" name="status" value="DONE">
                      <button class="btn btn-success btn-sm" style="font-size:10px;padding:2px 8px;">✓ Mark Done</button>
                    </form>
                  </div>
                </div>
              </c:if>
            </c:forEach>
          </div>
        </div>

        <!-- DONE Column -->
        <div class="col-md-4">
          <div class="kanban-col" style="background:#f0fdf4;">
            <div class="kanban-col-header">
              <span style="width:10px;height:10px;border-radius:50%;background:#10b981;display:inline-block;"></span>
              Done
              <span class="badge badge-success ms-auto">
                <c:set var="doneC" value="0"/>
                <c:forEach var="t" items="${tasks}"><c:if test="${t.status == 'DONE'}"><c:set var="doneC" value="${doneC+1}"/></c:if></c:forEach>
                ${doneC}
              </span>
            </div>
            <c:forEach var="t" items="${tasks}">
              <c:if test="${t.status == 'DONE'}">
                <div class="task-card" style="position:relative;padding-left:16px;opacity:0.75;">
                  <div class="task-priority" style="background:#10b981;"></div>
                  <div class="fw-600 small mb-1" style="text-decoration:line-through;">${t.title}</div>
                  <div style="display:flex;justify-content:space-between;align-items:center;">
                    <span class="badge badge-secondary" style="font-size:10px;">${t.assignedTo.firstName}</span>
                    <span class="badge badge-success" style="font-size:10px;">✓ Completed</span>
                  </div>
                </div>
              </c:if>
            </c:forEach>
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
