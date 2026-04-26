<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Attendance — Smart HRMS</title>
  <%@ include file="/WEB-INF/views/common/head.jsp" %>
</head>
<body>
<div class="wrapper">
  <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
  <div class="main-content">
    <c:set var="pageTitle" value="My Attendance" />
    <%@ include file="/WEB-INF/views/common/topbar.jsp" %>
    <div class="page-body fade-in">
      <%@ include file="/WEB-INF/views/common/alerts.jsp" %>

      <div class="row g-4">

        <!-- Check In/Out Card -->
        <div class="col-lg-5">
          <div class="card">
            <div class="card-header">
              <h5><i class="bi bi-clock-fill text-primary me-2"></i>Mark Attendance</h5>
            </div>
            <div class="card-body text-center" style="padding:36px 24px;">

              <!-- Live Clock -->
              <div style="font-size:48px;font-weight:800;color:var(--primary);letter-spacing:-2px;" id="bigClock"></div>
              <div class="text-muted small mb-4" id="bigDate"></div>

              <c:choose>
                <c:when test="${todayAttendance == null}">
                  <!-- Not checked in yet -->
                  <div style="margin-bottom:24px;">
                    <div style="font-size:64px;">🕐</div>
                    <div class="fw-bold" style="font-size:16px;margin-bottom:4px;">Not Checked In</div>
                    <div class="text-muted small">Mark your presence for today</div>
                  </div>
                  <form action="${pageContext.request.contextPath}/attendance/checkin" method="post" enctype="multipart/form-data">
                    <div class="form-group text-start mb-3">
                      <label class="form-label">Attendance Photo <span class="text-muted small">(optional)</span></label>
                      <input type="file" name="photo" id="photoInput" accept="image/*" class="form-control">
                      <img id="photoPreview" src="" style="display:none;width:80px;height:80px;border-radius:8px;object-fit:cover;margin-top:8px;">
                    </div>
                    <button type="submit" class="btn btn-success btn-lg w-100">
                      <i class="bi bi-box-arrow-in-right"></i> &nbsp;Check In
                    </button>
                  </form>
                </c:when>
                <c:when test="${todayAttendance.checkOutTime == null}">
                  <!-- Checked in, not out -->
                  <div style="margin-bottom:24px;">
                    <div style="font-size:64px;">✅</div>
                    <div class="fw-bold text-success" style="font-size:16px;margin-bottom:4px;">Checked In</div>
                    <div class="text-muted small">
                      Since <strong><fmt:formatDate value="${todayAttendance.checkInTime}" pattern="hh:mm a" type="time"/></strong>
                    </div>
                    <span class="badge ${todayAttendance.status == 'LATE' ? 'badge-warning' : 'badge-success'} mt-2">
                      ${todayAttendance.status}
                    </span>
                  </div>
                  <form action="${pageContext.request.contextPath}/attendance/checkout" method="post">
                    <button type="submit" class="btn btn-danger btn-lg w-100">
                      <i class="bi bi-box-arrow-right"></i> &nbsp;Check Out
                    </button>
                  </form>
                </c:when>
                <c:otherwise>
                  <!-- Full day complete -->
                  <div style="margin-bottom:24px;">
                    <div style="font-size:64px;">🎉</div>
                    <div class="fw-bold" style="font-size:16px;margin-bottom:8px;">Day Complete!</div>
                    <div class="text-muted small mb-1">
                      In: <strong><fmt:formatDate value="${todayAttendance.checkInTime}" pattern="hh:mm a" type="time"/></strong>
                      &nbsp;→&nbsp;
                      Out: <strong><fmt:formatDate value="${todayAttendance.checkOutTime}" pattern="hh:mm a" type="time"/></strong>
                    </div>
                    <div class="text-muted small">Working Hours: <strong>${todayAttendance.workingHours}</strong></div>
                  </div>
                  <div class="alert alert-success">
                    <i class="bi bi-check-circle-fill"></i> Attendance marked for today
                  </div>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
        </div>

        <!-- Recent History -->
        <div class="col-lg-7">
          <div class="card">
            <div class="card-header">
              <h5><i class="bi bi-calendar3 text-primary me-2"></i>Recent Attendance</h5>
              <a href="${pageContext.request.contextPath}/attendance/history" class="btn btn-outline btn-sm">Full History</a>
            </div>
            <div class="table-wrapper">
              <table class="hrms-table">
                <thead>
                  <tr>
                    <th>Date</th><th>Check In</th><th>Check Out</th><th>Hours</th><th>Status</th>
                  </tr>
                </thead>
                <tbody>
                  <c:choose>
                    <c:when test="${empty history}">
                      <tr><td colspan="5" class="text-center text-muted" style="padding:40px;">No attendance records found</td></tr>
                    </c:when>
                    <c:otherwise>
                      <c:forEach var="a" items="${history}">
                        <tr>
                          <td class="fw-600">${a.attendanceDate}</td>
                          <td>
                            <c:choose>
                              <c:when test="${a.checkInTime != null}">
                                <fmt:formatDate value="${a.checkInTime}" pattern="hh:mm a" type="time"/>
                              </c:when>
                              <c:otherwise><span class="text-muted">—</span></c:otherwise>
                            </c:choose>
                          </td>
                          <td>
                            <c:choose>
                              <c:when test="${a.checkOutTime != null}">
                                <fmt:formatDate value="${a.checkOutTime}" pattern="hh:mm a" type="time"/>
                              </c:when>
                              <c:otherwise><span class="text-muted">—</span></c:otherwise>
                            </c:choose>
                          </td>
                          <td class="small text-muted">${a.checkOutTime != null ? a.workingHours : '—'}</td>
                          <td>
                            <span class="badge
                              <c:choose>
                                <c:when test="${a.status == 'PRESENT'}">badge-success</c:when>
                                <c:when test="${a.status == 'LATE'}">badge-warning</c:when>
                                <c:when test="${a.status == 'ABSENT'}">badge-danger</c:when>
                                <c:otherwise>badge-secondary</c:otherwise>
                              </c:choose>">${a.status}</span>
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
      </div>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
<script>
function updateClock() {
  var d = new Date();
  document.getElementById('bigClock').textContent = d.toLocaleTimeString('en-IN',{hour:'2-digit',minute:'2-digit',second:'2-digit'});
  document.getElementById('bigDate').textContent = d.toLocaleDateString('en-IN',{weekday:'long',year:'numeric',month:'long',day:'numeric'});
}
updateClock(); setInterval(updateClock, 1000);
</script>
</body>
</html>
