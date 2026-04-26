<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Payslip — Smart HRMS</title>
  <%@ include file="/WEB-INF/views/common/head.jsp" %>
  <style>
    @media print {
      .sidebar, .topbar, .no-print { display: none !important; }
      .main-content { margin-left: 0 !important; }
      .page-body { padding: 0 !important; }
    }
  </style>
</head>
<body>
<div class="wrapper">
  <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
  <div class="main-content">
    <c:set var="pageTitle" value="Pay Slip" />
    <%@ include file="/WEB-INF/views/common/topbar.jsp" %>
    <div class="page-body fade-in">

      <div class="d-flex justify-content-end gap-2 mb-3 no-print">
        <a href="${pageContext.request.contextPath}/payroll" class="btn btn-outline btn-sm"><i class="bi bi-arrow-left"></i> Back</a>
        <button onclick="window.print()" class="btn btn-primary btn-sm"><i class="bi bi-printer"></i> Print</button>
      </div>

      <div class="payslip">
        <!-- Header -->
        <div class="payslip-header">
          <div style="display:flex;justify-content:space-between;align-items:flex-start;">
            <div>
              <h3>🏢 Smart HRMS</h3>
              <p style="opacity:0.8;font-size:13px;margin:0;">Official Salary Slip</p>
            </div>
            <div style="text-align:right;">
              <div style="font-size:20px;font-weight:800;">${payroll.salaryMonth}</div>
              <div style="opacity:0.75;font-size:12px;">Pay Period</div>
            </div>
          </div>
        </div>

        <div style="padding:24px 28px;">
          <!-- Employee Info -->
          <div style="display:flex;gap:24px;padding-bottom:20px;border-bottom:2px solid var(--border);margin-bottom:20px;flex-wrap:wrap;">
            <div>
              <div class="text-muted small mb-1">Employee Name</div>
              <div class="fw-bold" style="font-size:16px;">${payroll.employee.firstName} ${payroll.employee.lastName}</div>
            </div>
            <div>
              <div class="text-muted small mb-1">Employee Code</div>
              <div class="fw-600">${payroll.employee.employeeCode}</div>
            </div>
            <div>
              <div class="text-muted small mb-1">Department</div>
              <div class="fw-600">${payroll.employee.department.departmentName}</div>
            </div>
            <div>
              <div class="text-muted small mb-1">Designation</div>
              <div class="fw-600">${payroll.employee.role.roleName}</div>
            </div>
          </div>

          <!-- Earnings -->
          <div class="row g-4">
            <div class="col-md-6">
              <div class="fw-bold mb-3" style="color:var(--success);">💰 Earnings</div>
              <div class="payslip-row">
                <span class="text-muted">Basic Salary</span>
                <span class="fw-600">₹ <fmt:formatNumber value="${payroll.baseSalary}" pattern="#,##0.00"/></span>
              </div>
              <div class="payslip-row">
                <span class="text-muted">Bonus / Incentive</span>
                <span class="fw-600" style="color:var(--success);">+ ₹ <fmt:formatNumber value="${payroll.bonus}" pattern="#,##0.00"/></span>
              </div>
              <div class="payslip-row fw-bold" style="padding-top:12px;border-top:2px solid var(--border);margin-top:4px;">
                <span>Gross Earnings</span>
                <span style="color:var(--success);">₹ <fmt:formatNumber value="${payroll.baseSalary + payroll.bonus}" pattern="#,##0.00"/></span>
              </div>
            </div>
            <div class="col-md-6">
              <div class="fw-bold mb-3" style="color:var(--danger);">📉 Deductions</div>
              <div class="payslip-row">
                <span class="text-muted">Total Deductions</span>
                <span class="fw-600" style="color:var(--danger);">- ₹ <fmt:formatNumber value="${payroll.deductions}" pattern="#,##0.00"/></span>
              </div>
            </div>
          </div>

          <!-- Net Pay -->
          <div style="background:linear-gradient(135deg,var(--primary),var(--primary-dark));color:#fff;border-radius:var(--radius);padding:20px 24px;margin-top:20px;display:flex;justify-content:space-between;align-items:center;">
            <div>
              <div style="font-size:13px;opacity:0.8;margin-bottom:4px;">Net Take Home Salary</div>
              <div style="font-size:28px;font-weight:800;">₹ <fmt:formatNumber value="${payroll.netSalary}" pattern="#,##0.00"/></div>
            </div>
            <div style="font-size:40px;">💵</div>
          </div>

          <div style="margin-top:24px;font-size:11px;color:#94a3b8;text-align:center;border-top:1px solid var(--border);padding-top:16px;">
            This is a computer-generated payslip and does not require a physical signature. &bull; Smart HRMS &copy; ${java.time.Year.now().value}
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
