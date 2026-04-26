<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Apply Leave — Smart HRMS</title>
  <%@ include file="/WEB-INF/views/common/head.jsp" %>
</head>
<body>
<div class="wrapper">
  <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
  <div class="main-content">
    <c:set var="pageTitle" value="Apply for Leave" />
    <%@ include file="/WEB-INF/views/common/topbar.jsp" %>
    <div class="page-body fade-in">
      <%@ include file="/WEB-INF/views/common/alerts.jsp" %>

      <div class="row justify-content-center">
        <div class="col-lg-7">
          <div class="card">
            <div class="card-header">
              <h5><i class="bi bi-calendar2-plus-fill text-primary me-2"></i>New Leave Application</h5>
              <a href="${pageContext.request.contextPath}/leaves" class="btn btn-outline btn-sm">
                <i class="bi bi-arrow-left"></i> Back
              </a>
            </div>
            <div class="card-body">
              <form action="${pageContext.request.contextPath}/leaves/apply" method="post">

                <div class="row g-3">
                  <div class="col-12">
                    <div class="form-group">
                      <label class="form-label">Leave Type *</label>
                      <div class="d-flex gap-3" style="flex-wrap:wrap;">
                        <label style="flex:1;min-width:120px;">
                          <input type="radio" name="leaveType" value="FULL" required style="display:none;" id="fullDay">
                          <div class="leave-type-card" onclick="selectType('fullDay')">
                            <div style="font-size:28px;margin-bottom:6px;">📅</div>
                            <div class="fw-600 small">Full Day</div>
                          </div>
                        </label>
                        <label style="flex:1;min-width:120px;">
                          <input type="radio" name="leaveType" value="HALF" style="display:none;" id="halfDay">
                          <div class="leave-type-card" onclick="selectType('halfDay')">
                            <div style="font-size:28px;margin-bottom:6px;">🌤️</div>
                            <div class="fw-600 small">Half Day</div>
                          </div>
                        </label>
                        <label style="flex:1;min-width:120px;">
                          <input type="radio" name="leaveType" value="WFH" style="display:none;" id="wfh">
                          <div class="leave-type-card" onclick="selectType('wfh')">
                            <div style="font-size:28px;margin-bottom:6px;">🏠</div>
                            <div class="fw-600 small">Work From Home</div>
                          </div>
                        </label>
                      </div>
                    </div>
                  </div>

                  <div class="col-md-6">
                    <div class="form-group">
                      <label class="form-label">Start Date *</label>
                      <input type="date" name="startDate" class="form-control" required
                             min="${java.time.LocalDate.now()}">
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="form-group">
                      <label class="form-label">End Date *</label>
                      <input type="date" name="endDate" class="form-control" required
                             min="${java.time.LocalDate.now()}">
                    </div>
                  </div>

                  <div class="col-12">
                    <div class="form-group">
                      <label class="form-label">Reason *</label>
                      <textarea name="reason" class="form-control" rows="4"
                                placeholder="Please describe the reason for your leave request..." required></textarea>
                    </div>
                  </div>
                </div>

                <div class="d-flex justify-content-end gap-2 mt-4">
                  <a href="${pageContext.request.contextPath}/leaves" class="btn btn-outline">Cancel</a>
                  <button type="submit" class="btn btn-primary">
                    <i class="bi bi-send"></i> Submit Application
                  </button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<style>
.leave-type-card {
  border: 2px solid var(--border);
  border-radius: var(--radius);
  padding: 16px;
  text-align: center;
  cursor: pointer;
  transition: all 0.2s;
}
.leave-type-card:hover, .leave-type-card.selected {
  border-color: var(--primary);
  background: var(--primary-light);
}
</style>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
<script>
function selectType(id) {
  document.querySelectorAll('.leave-type-card').forEach(function(c){c.classList.remove('selected');});
  document.getElementById(id).checked = true;
  document.getElementById(id).nextElementSibling.classList.add('selected');
}
</script>
</body>
</html>
