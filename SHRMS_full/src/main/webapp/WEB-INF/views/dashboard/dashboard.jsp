<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Dashboard — Smart HRMS</title>
  <%@ include file="/WEB-INF/views/common/head.jsp" %>
</head>
<body>
<div class="wrapper">
  <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
  <div class="main-content">
    <c:set var="pageTitle" value="Dashboard" />
    <%@ include file="/WEB-INF/views/common/topbar.jsp" %>
    <div class="page-body fade-in">

      <%@ include file="/WEB-INF/views/common/alerts.jsp" %>

      <!-- Welcome Banner -->
      <div class="card mb-4" style="background:linear-gradient(135deg,#4f46e5,#7c3aed);border:none;color:#fff;">
        <div class="card-body" style="padding:28px 32px;display:flex;justify-content:space-between;align-items:center;">
          <div>
            <h4 style="font-weight:800;margin:0 0 6px;font-size:22px;">
              Good day, ${employee.firstName}! 👋
            </h4>
            <p style="margin:0;opacity:0.85;font-size:14px;">
              ${employee.role.roleName} &bull; ${employee.department.departmentName} &bull; ${employee.employeeCode}
            </p>
          </div>
          <div style="text-align:right;">
            <div style="font-size:28px;font-weight:800;" id="liveTime"></div>
            <div style="opacity:0.75;font-size:13px;" id="liveDate"></div>
          </div>
        </div>
      </div>

      <!-- ADMIN / HR Stats -->
      <c:if test="${role == 'ADMIN' || role == 'HR'}">
      <div class="row g-3 mb-4">
        <div class="col-sm-6 col-xl-3">
          <div class="stat-card">
            <div class="stat-icon bg-primary"><i class="bi bi-people-fill"></i></div>
            <div class="stat-info">
              <div class="stat-value">${totalEmployees}</div>
              <div class="stat-label">Active Employees</div>
            </div>
          </div>
        </div>
        <div class="col-sm-6 col-xl-3">
          <div class="stat-card">
            <div class="stat-icon bg-success"><i class="bi bi-check-circle-fill"></i></div>
            <div class="stat-info">
              <div class="stat-value">${presentToday}</div>
              <div class="stat-label">Present Today</div>
            </div>
          </div>
        </div>
        <div class="col-sm-6 col-xl-3">
          <div class="stat-card">
            <div class="stat-icon bg-warning"><i class="bi bi-calendar2-minus-fill"></i></div>
            <div class="stat-info">
              <div class="stat-value">${pendingLeaves}</div>
              <div class="stat-label">Pending Leaves</div>
            </div>
          </div>
        </div>
        <div class="col-sm-6 col-xl-3">
          <div class="stat-card">
            <div class="stat-icon bg-accent"><i class="bi bi-currency-dollar"></i></div>
            <div class="stat-info">
              <div class="stat-value">${recentPayrolls.size()}</div>
              <div class="stat-label">Payrolls This Month</div>
            </div>
          </div>
        </div>
      </div>
      </c:if>

      <!-- MANAGER Stats -->
      <c:if test="${role == 'MANAGER'}">
      <div class="row g-3 mb-4">
        <div class="col-sm-6 col-xl-3">
          <div class="stat-card">
            <div class="stat-icon bg-primary"><i class="bi bi-people-fill"></i></div>
            <div class="stat-info">
              <div class="stat-value">${myTeam.size()}</div>
              <div class="stat-label">Team Members</div>
            </div>
          </div>
        </div>
        <div class="col-sm-6 col-xl-3">
          <div class="stat-card">
            <div class="stat-icon bg-warning"><i class="bi bi-hourglass-split"></i></div>
            <div class="stat-info">
              <div class="stat-value">${pendingLeaves}</div>
              <div class="stat-label">Pending Leave Approvals</div>
            </div>
          </div>
        </div>
        <div class="col-sm-6 col-xl-3">
          <div class="stat-card">
            <div class="stat-icon bg-info"><i class="bi bi-list-task"></i></div>
            <div class="stat-info">
              <div class="stat-value">${teamTasks.size()}</div>
              <div class="stat-label">Team Tasks</div>
            </div>
          </div>
        </div>
        <div class="col-sm-6 col-xl-3">
          <div class="stat-card">
            <div class="stat-icon bg-success"><i class="bi bi-clock-fill"></i></div>
            <div class="stat-info">
              <div class="stat-value">${presentDays}</div>
              <div class="stat-label">Your Days Present (Month)</div>
            </div>
          </div>
        </div>
      </div>
      </c:if>

      <!-- EMPLOYEE Stats -->
      <c:if test="${role == 'EMPLOYEE'}">
      <div class="row g-3 mb-4">
        <div class="col-sm-6 col-xl-3">
          <div class="stat-card">
            <div class="stat-icon bg-success"><i class="bi bi-clock-fill"></i></div>
            <div class="stat-info">
              <div class="stat-value">${presentDays}</div>
              <div class="stat-label">Days Present (Month)</div>
            </div>
          </div>
        </div>
        <div class="col-sm-6 col-xl-3">
          <div class="stat-card">
            <div class="stat-icon bg-primary"><i class="bi bi-list-task"></i></div>
            <div class="stat-info">
              <div class="stat-value">${todoCount}</div>
              <div class="stat-label">Tasks To-Do</div>
            </div>
          </div>
        </div>
        <div class="col-sm-6 col-xl-3">
          <div class="stat-card">
            <div class="stat-icon bg-warning"><i class="bi bi-arrow-clockwise"></i></div>
            <div class="stat-info">
              <div class="stat-value">${inProgressCount}</div>
              <div class="stat-label">In Progress</div>
            </div>
          </div>
        </div>
        <div class="col-sm-6 col-xl-3">
          <div class="stat-card">
            <div class="stat-icon bg-accent"><i class="bi bi-check2-all"></i></div>
            <div class="stat-info">
              <div class="stat-value">${doneCount}</div>
              <div class="stat-label">Tasks Completed</div>
            </div>
          </div>
        </div>
      </div>
      </c:if>

      <div class="row g-4">

        <!-- Today Attendance -->
        <div class="col-lg-4">
          <div class="card h-100">
            <div class="card-header">
              <h5><i class="bi bi-clock-fill text-primary me-2"></i>Today's Attendance</h5>
              <a href="${pageContext.request.contextPath}/attendance" class="btn btn-outline btn-sm">Go</a>
            </div>
            <div class="card-body text-center" style="padding:28px;">
              <c:choose>
                <c:when test="${todayAttendance != null}">
                  <div style="font-size:48px;margin-bottom:8px;">✅</div>
                  <div class="fw-bold" style="font-size:16px;margin-bottom:4px;">Checked In</div>
                  <div class="text-muted small">
                    In: <fmt:formatDate value="${todayAttendance.checkInTime}" pattern="hh:mm a" type="time"/>
                    <c:if test="${todayAttendance.checkOutTime != null}">
                      &bull; Out: <fmt:formatDate value="${todayAttendance.checkOutTime}" pattern="hh:mm a" type="time"/>
                    </c:if>
                  </div>
                  <span class="badge mt-2
                    <c:choose>
                      <c:when test="${todayAttendance.status == 'PRESENT'}">badge-success</c:when>
                      <c:when test="${todayAttendance.status == 'LATE'}">badge-warning</c:when>
                      <c:otherwise>badge-secondary</c:otherwise>
                    </c:choose>">${todayAttendance.status}</span>
                </c:when>
                <c:otherwise>
                  <div style="font-size:48px;margin-bottom:8px;">⏰</div>
                  <div class="fw-bold" style="font-size:16px;margin-bottom:4px;">Not Checked In</div>
                  <div class="text-muted small mb-3">Mark your attendance for today</div>
                  <a href="${pageContext.request.contextPath}/attendance" class="btn btn-primary btn-sm">
                    <i class="bi bi-box-arrow-in-right"></i> Check In Now
                  </a>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
        </div>

        <!-- My Tasks -->
        <div class="col-lg-4">
          <div class="card h-100">
            <div class="card-header">
              <h5><i class="bi bi-check2-square text-primary me-2"></i>My Tasks</h5>
              <a href="${pageContext.request.contextPath}/tasks" class="btn btn-outline btn-sm">View All</a>
            </div>
            <div class="card-body" style="padding:12px;">
              <c:choose>
                <c:when test="${empty myTasks}">
                  <div class="text-center text-muted" style="padding:40px 20px;">
                    <i class="bi bi-inbox" style="font-size:32px;display:block;margin-bottom:8px;"></i>
                    No tasks assigned
                  </div>
                </c:when>
                <c:otherwise>
                  <c:forEach var="t" items="${myTasks}" varStatus="s">
                    <c:if test="${s.index < 5}">
                    <div style="padding:10px 8px;border-bottom:1px solid #f1f5f9;display:flex;align-items:center;gap:10px;">
                      <span class="badge
                        <c:choose>
                          <c:when test="${t.priority == 'HIGH'}">badge-danger</c:when>
                          <c:when test="${t.priority == 'MEDIUM'}">badge-warning</c:when>
                          <c:otherwise>badge-secondary</c:otherwise>
                        </c:choose>">${t.priority}</span>
                      <span style="flex:1;font-size:13px;font-weight:500;">${t.title}</span>
                      <span class="badge
                        <c:choose>
                          <c:when test="${t.status == 'DONE'}">badge-success</c:when>
                          <c:when test="${t.status == 'IN_PROGRESS'}">badge-info</c:when>
                          <c:otherwise>badge-secondary</c:otherwise>
                        </c:choose>" style="font-size:10px;">${t.status}</span>
                    </div>
                    </c:if>
                  </c:forEach>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
        </div>

        <!-- Upcoming Holidays -->
        <div class="col-lg-4">
          <div class="card h-100">
            <div class="card-header">
              <h5><i class="bi bi-star-fill text-warning me-2"></i>Upcoming Holidays</h5>
              <a href="${pageContext.request.contextPath}/holidays" class="btn btn-outline btn-sm">All</a>
            </div>
            <div class="card-body" style="padding:12px;">
              <c:choose>
                <c:when test="${empty upcomingHolidays}">
                  <div class="text-center text-muted" style="padding:40px 20px;">
                    <i class="bi bi-calendar3" style="font-size:32px;display:block;margin-bottom:8px;"></i>
                    No upcoming holidays
                  </div>
                </c:when>
                <c:otherwise>
                  <c:forEach var="h" items="${upcomingHolidays}">
                    <div style="padding:10px 8px;border-bottom:1px solid #f1f5f9;display:flex;align-items:center;gap:12px;">
                      <div style="width:44px;height:44px;background:var(--primary-light);border-radius:8px;display:flex;flex-direction:column;align-items:center;justify-content:center;flex-shrink:0;">
                        <span style="font-size:16px;font-weight:800;color:var(--primary);line-height:1;">${h.holidayDate.dayOfMonth}</span>
                        <span style="font-size:9px;color:var(--primary);font-weight:600;">${h.holidayDate.month.toString().substring(0,3)}</span>
                      </div>
                      <div>
                        <div style="font-weight:600;font-size:13px;">${h.holidayName}</div>
                        <div class="text-muted small">${h.holidayType}</div>
                      </div>
                    </div>
                  </c:forEach>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
        </div>

        <!-- Recent Leaves -->
        <div class="col-lg-6">
          <div class="card">
            <div class="card-header">
              <h5><i class="bi bi-calendar2-minus text-primary me-2"></i>Recent Leave Requests</h5>
              <a href="${pageContext.request.contextPath}/leaves" class="btn btn-outline btn-sm">View All</a>
            </div>
            <div class="table-wrapper">
              <table class="hrms-table">
                <thead>
                  <tr>
                    <th>Type</th><th>From</th><th>To</th><th>Status</th>
                  </tr>
                </thead>
                <tbody>
                  <c:choose>
                    <c:when test="${empty myLeaves}">
                      <tr><td colspan="4" class="text-center text-muted" style="padding:30px;">No leave requests found</td></tr>
                    </c:when>
                    <c:otherwise>
                      <c:forEach var="l" items="${myLeaves}">
                        <tr>
                          <td><span class="badge badge-info">${l.leaveType}</span></td>
                          <td>${l.startDate}</td>
                          <td>${l.endDate}</td>
                          <td>
                            <span class="badge
                              <c:choose>
                                <c:when test="${l.status == 'APPROVED'}">badge-success</c:when>
                                <c:when test="${l.status == 'REJECTED'}">badge-danger</c:when>
                                <c:otherwise>badge-warning</c:otherwise>
                              </c:choose>">${l.status}</span>
                          </td>
                        </tr>
                      </c:forEach>
                    </c:otherwise>
                  </c:choose>
                </tbody>
              </table>
            </div>
          </div>
        </div>

        <!-- Admin: Pending Leaves -->
        <c:if test="${role == 'ADMIN' || role == 'HR' || role == 'MANAGER'}">
        <div class="col-lg-6">
          <div class="card">
            <div class="card-header">
              <h5><i class="bi bi-clipboard-check text-warning me-2"></i>Pending Approvals</h5>
              <a href="${pageContext.request.contextPath}/leaves/manage" class="btn btn-outline btn-sm">Manage</a>
            </div>
            <div class="table-wrapper">
              <table class="hrms-table">
                <thead>
                  <tr><th>Employee</th><th>Type</th><th>Dates</th><th>Action</th></tr>
                </thead>
                <tbody>
                  <c:choose>
                    <c:when test="${empty allLeaves}">
                      <tr><td colspan="4" class="text-center text-muted" style="padding:30px;">No pending leaves 🎉</td></tr>
                    </c:when>
                    <c:otherwise>
                      <c:forEach var="l" items="${allLeaves}" varStatus="s">
                        <c:if test="${s.index < 5}">
                        <tr>
                          <td>
                            <div style="font-weight:600;font-size:13px;">${l.employee.firstName} ${l.employee.lastName}</div>
                            <div class="text-muted small">${l.employee.department.departmentName}</div>
                          </td>
                          <td><span class="badge badge-info">${l.leaveType}</span></td>
                          <td class="small text-muted">${l.startDate} → ${l.endDate}</td>
                          <td>
                            <form action="${pageContext.request.contextPath}/leaves/action/${l.leaveId}" method="post" style="display:inline;">
                              <input type="hidden" name="action" value="APPROVED">
                              <button class="btn btn-success btn-sm btn-icon" title="Approve"><i class="bi bi-check-lg"></i></button>
                            </form>
                            <form action="${pageContext.request.contextPath}/leaves/action/${l.leaveId}" method="post" style="display:inline;">
                              <input type="hidden" name="action" value="REJECTED">
                              <button class="btn btn-danger btn-sm btn-icon" title="Reject"><i class="bi bi-x-lg"></i></button>
                            </form>
                          </td>
                        </tr>
                        </c:if>
                      </c:forEach>
                    </c:otherwise>
                  </c:choose>
                </tbody>
              </table>
            </div>
          </div>
        </div>
        </c:if>

      </div><!-- /row -->
    </div><!-- /page-body -->
  </div><!-- /main-content -->
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
<script>
function updateClock() {
  var now = new Date();
  document.getElementById('liveTime').textContent = now.toLocaleTimeString('en-IN', {hour:'2-digit',minute:'2-digit',second:'2-digit'});
  document.getElementById('liveDate').textContent = now.toLocaleDateString('en-IN', {weekday:'long',year:'numeric',month:'long',day:'numeric'});
}
updateClock(); setInterval(updateClock, 1000);
</script>
</body>
</html>
