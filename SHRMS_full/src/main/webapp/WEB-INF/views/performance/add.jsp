<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Add Performance Review — Smart HRMS</title>
  <%@ include file="/WEB-INF/views/common/head.jsp" %>
</head>
<body>
<div class="wrapper">
  <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
  <div class="main-content">
    <c:set var="pageTitle" value="Add Performance Review" />
    <%@ include file="/WEB-INF/views/common/topbar.jsp" %>
    <div class="page-body fade-in">
      <%@ include file="/WEB-INF/views/common/alerts.jsp" %>
      <div class="row justify-content-center">
        <div class="col-lg-7">
          <div class="card">
            <div class="card-header">
              <h5><i class="bi bi-graph-up-arrow text-primary me-2"></i>New Performance Review</h5>
              <a href="${pageContext.request.contextPath}/performance" class="btn btn-outline btn-sm">
                <i class="bi bi-arrow-left"></i> Back
              </a>
            </div>
            <div class="card-body">
              <form action="${pageContext.request.contextPath}/performance/add" method="post">
                <div class="row g-3">
                  <div class="col-md-6">
                    <div class="form-group">
                      <label class="form-label">Employee *</label>
                      <select name="employeeId" class="form-select" required>
                        <option value="">Select Employee</option>
                        <c:forEach var="emp" items="${employees}">
                          <option value="${emp.employeeId}">${emp.firstName} ${emp.lastName} — ${emp.employeeCode}</option>
                        </c:forEach>
                      </select>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="form-group">
                      <label class="form-label">Review Period *</label>
                      <input type="text" name="period" class="form-control" placeholder="e.g. Q1-2024, 2024-01" required>
                    </div>
                  </div>

                  <!-- Star Rating -->
                  <div class="col-12">
                    <div class="form-group">
                      <label class="form-label">Overall Rating (1–5) *</label>
                      <div class="d-flex gap-2 align-items-center">
                        <c:forEach begin="1" end="5" var="star">
                          <label style="cursor:pointer;font-size:32px;line-height:1;" title="${star} star">
                            <input type="radio" name="rating" value="${star}" style="display:none;"
                                   onchange="highlightStars(${star})">
                            <span class="star-icon" id="star${star}">☆</span>
                          </label>
                        </c:forEach>
                        <span id="ratingLabel" class="text-muted small ms-2">Click to rate</span>
                      </div>
                    </div>
                  </div>

                  <div class="col-md-6">
                    <div class="form-group">
                      <label class="form-label">Attendance Score (0–100) *</label>
                      <div style="display:flex;align-items:center;gap:12px;">
                        <input type="range" name="attendanceScore" id="attRange" min="0" max="100" value="80"
                               oninput="document.getElementById('attVal').textContent = this.value"
                               style="flex:1;">
                        <span id="attVal" class="badge badge-success" style="font-size:13px;min-width:40px;justify-content:center;">80</span>
                      </div>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="form-group">
                      <label class="form-label">Task Score (0–100) *</label>
                      <div style="display:flex;align-items:center;gap:12px;">
                        <input type="range" name="taskScore" id="taskRange" min="0" max="100" value="80"
                               oninput="document.getElementById('taskVal').textContent = this.value"
                               style="flex:1;">
                        <span id="taskVal" class="badge badge-info" style="font-size:13px;min-width:40px;justify-content:center;">80</span>
                      </div>
                    </div>
                  </div>

                  <div class="col-12">
                    <div class="form-group">
                      <label class="form-label">Remarks</label>
                      <textarea name="remarks" class="form-control" rows="3"
                                placeholder="Add feedback, comments, or improvement areas..."></textarea>
                    </div>
                  </div>
                </div>

                <div class="d-flex justify-content-end gap-2 mt-4">
                  <a href="${pageContext.request.contextPath}/performance" class="btn btn-outline">Cancel</a>
                  <button type="submit" class="btn btn-primary">
                    <i class="bi bi-save"></i> Save Review
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
<script>
var ratingLabels = ['', 'Poor', 'Below Average', 'Average', 'Good', 'Excellent'];
function highlightStars(n) {
  for (var i = 1; i <= 5; i++) {
    document.getElementById('star' + i).textContent = i <= n ? '⭐' : '☆';
  }
  document.getElementById('ratingLabel').textContent = ratingLabels[n] + ' (' + n + '/5)';
}
</script>
</body>
</html>
