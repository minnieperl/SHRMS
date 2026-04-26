<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Generate Payroll — Smart HRMS</title>
  <%@ include file="/WEB-INF/views/common/head.jsp" %>
</head>
<body>
<div class="wrapper">
  <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
  <div class="main-content">
    <c:set var="pageTitle" value="Generate Payroll" />
    <%@ include file="/WEB-INF/views/common/topbar.jsp" %>
    <div class="page-body fade-in">
      <%@ include file="/WEB-INF/views/common/alerts.jsp" %>
      <div class="row justify-content-center">
        <div class="col-lg-6">
          <div class="card">
            <div class="card-header">
              <h5><i class="bi bi-currency-dollar text-primary me-2"></i>Generate Payroll</h5>
              <a href="${pageContext.request.contextPath}/payroll" class="btn btn-outline btn-sm"><i class="bi bi-arrow-left"></i> Back</a>
            </div>
            <div class="card-body">
              <form action="${pageContext.request.contextPath}/payroll/generate" method="post">
                <div class="form-group">
                  <label class="form-label">Select Employee *</label>
                  <select name="employeeId" class="form-select" required onchange="loadSalary(this)">
                    <option value="">Choose employee...</option>
                    <c:forEach var="emp" items="${employees}">
                      <option value="${emp.employeeId}" data-salary="${emp.baseSalary}">
                        ${emp.firstName} ${emp.lastName} — ${emp.employeeCode}
                      </option>
                    </c:forEach>
                  </select>
                </div>
                <div class="form-group">
                  <label class="form-label">Salary Month *</label>
                  <input type="month" name="salaryMonth" class="form-control" required>
                </div>
                <div class="row g-3">
                  <div class="col-md-6">
                    <div class="form-group">
                      <label class="form-label">Base Salary (₹)</label>
                      <input type="number" name="baseSalaryDisplay" id="baseSalaryDisplay" class="form-control" disabled placeholder="Auto from employee">
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="form-group">
                      <label class="form-label">Deductions (₹)</label>
                      <input type="number" name="deductions" class="form-control" value="0" step="0.01" min="0" required>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="form-group">
                      <label class="form-label">Bonus (₹)</label>
                      <input type="number" name="bonus" class="form-control" value="0" step="0.01" min="0" required>
                    </div>
                  </div>
                </div>
                <div class="d-flex justify-content-end gap-2 mt-4">
                  <a href="${pageContext.request.contextPath}/payroll" class="btn btn-outline">Cancel</a>
                  <button type="submit" class="btn btn-primary"><i class="bi bi-receipt"></i> Generate</button>
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
function loadSalary(sel) {
  var opt = sel.options[sel.selectedIndex];
  var salary = opt.dataset.salary;
  document.getElementById('baseSalaryDisplay').value = salary || '';
}
</script>
</body>
</html>
