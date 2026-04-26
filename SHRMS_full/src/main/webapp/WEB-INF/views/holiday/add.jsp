<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Add Holiday — Smart HRMS</title>
  <%@ include file="/WEB-INF/views/common/head.jsp" %>
</head>
<body>
<div class="wrapper">
  <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
  <div class="main-content">
    <c:set var="pageTitle" value="Add Holiday" />
    <%@ include file="/WEB-INF/views/common/topbar.jsp" %>
    <div class="page-body fade-in">
      <%@ include file="/WEB-INF/views/common/alerts.jsp" %>
      <div class="row justify-content-center">
        <div class="col-lg-5">
          <div class="card">
            <div class="card-header">
              <h5><i class="bi bi-star-fill text-warning me-2"></i>Add Company Holiday</h5>
              <a href="${pageContext.request.contextPath}/holidays" class="btn btn-outline btn-sm">
                <i class="bi bi-arrow-left"></i> Back
              </a>
            </div>
            <div class="card-body">
              <form action="${pageContext.request.contextPath}/holidays/add" method="post">
                <div class="form-group">
                  <label class="form-label">Holiday Name *</label>
                  <input type="text" name="holidayName" class="form-control"
                         placeholder="e.g. Diwali, Republic Day..." required>
                </div>
                <div class="form-group">
                  <label class="form-label">Date *</label>
                  <input type="date" name="holidayDate" class="form-control" required>
                </div>
                <div class="form-group">
                  <label class="form-label">Holiday Type *</label>
                  <div class="d-flex gap-2">
                    <label style="flex:1;cursor:pointer;">
                      <input type="radio" name="holidayType" value="NATIONAL" required style="display:none;" id="national">
                      <div class="leave-type-card" onclick="selectHType('national')" style="border:2px solid var(--border);border-radius:10px;padding:14px;text-align:center;">
                        <div style="font-size:24px;margin-bottom:4px;">🇮🇳</div>
                        <div class="fw-600 small">National</div>
                      </div>
                    </label>
                    <label style="flex:1;cursor:pointer;">
                      <input type="radio" name="holidayType" value="OPTIONAL" style="display:none;" id="optional">
                      <div class="leave-type-card" onclick="selectHType('optional')" style="border:2px solid var(--border);border-radius:10px;padding:14px;text-align:center;">
                        <div style="font-size:24px;margin-bottom:4px;">🟡</div>
                        <div class="fw-600 small">Optional</div>
                      </div>
                    </label>
                    <label style="flex:1;cursor:pointer;">
                      <input type="radio" name="holidayType" value="RESTRICTED" style="display:none;" id="restricted">
                      <div class="leave-type-card" onclick="selectHType('restricted')" style="border:2px solid var(--border);border-radius:10px;padding:14px;text-align:center;">
                        <div style="font-size:24px;margin-bottom:4px;">🔵</div>
                        <div class="fw-600 small">Restricted</div>
                      </div>
                    </label>
                  </div>
                </div>
                <div class="d-flex justify-content-end gap-2 mt-4">
                  <a href="${pageContext.request.contextPath}/holidays" class="btn btn-outline">Cancel</a>
                  <button type="submit" class="btn btn-primary">
                    <i class="bi bi-plus-circle"></i> Add Holiday
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
function selectHType(id) {
  document.querySelectorAll('.leave-type-card').forEach(function(c) {
    c.style.borderColor = 'var(--border)';
    c.style.background = '';
  });
  document.getElementById(id).checked = true;
  var card = document.getElementById(id).nextElementSibling;
  card.style.borderColor = 'var(--primary)';
  card.style.background = 'var(--primary-light)';
}
</script>
</body>
</html>
