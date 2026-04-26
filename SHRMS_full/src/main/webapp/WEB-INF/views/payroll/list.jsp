<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Payroll — Smart HRMS</title>
  <%@ include file="/WEB-INF/views/common/head.jsp" %>
</head>
<body>
<div class="wrapper">
  <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
  <div class="main-content">
    <c:set var="pageTitle" value="Payroll" />
    <%@ include file="/WEB-INF/views/common/topbar.jsp" %>
    <div class="page-body fade-in">
      <%@ include file="/WEB-INF/views/common/alerts.jsp" %>

      <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
          <h5 class="fw-bold mb-0">Payroll Records</h5>
          <p class="text-muted small mb-0">${payrolls.size()} records</p>
        </div>
        <c:if test="${role == 'ADMIN' || role == 'HR'}">
          <a href="${pageContext.request.contextPath}/payroll/generate" class="btn btn-primary">
            <i class="bi bi-plus-lg"></i> Generate Payroll
          </a>
        </c:if>
      </div>

      <div class="card">
        <div class="table-wrapper">
          <table class="hrms-table">
            <thead>
              <tr>
                <th>Employee</th>
                <th>Month</th>
                <th>Base Salary</th>
                <th>Deductions</th>
                <th>Bonus</th>
                <th>Net Salary</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <c:choose>
                <c:when test="${empty payrolls}">
                  <tr><td colspan="7" class="text-center text-muted" style="padding:50px;">No payroll records found.</td></tr>
                </c:when>
                <c:otherwise>
                  <c:forEach var="p" items="${payrolls}">
                    <tr>
                      <td>
                        <div class="d-flex align-items-center gap-2">
                          <div class="avatar" style="font-size:11px;">${p.employee.firstName.substring(0,1)}${p.employee.lastName.substring(0,1)}</div>
                          <div>
                            <div class="fw-600 small">${p.employee.firstName} ${p.employee.lastName}</div>
                            <div class="text-muted" style="font-size:11px;">${p.employee.employeeCode}</div>
                          </div>
                        </div>
                      </td>
                      <td><span class="badge badge-info">${p.salaryMonth}</span></td>
                      <td>₹ <fmt:formatNumber value="${p.baseSalary}" pattern="#,##0.00"/></td>
                      <td style="color:var(--danger);">- ₹ <fmt:formatNumber value="${p.deductions}" pattern="#,##0.00"/></td>
                      <td style="color:var(--success);">+ ₹ <fmt:formatNumber value="${p.bonus}" pattern="#,##0.00"/></td>
                      <td class="fw-bold" style="color:var(--primary);">₹ <fmt:formatNumber value="${p.netSalary}" pattern="#,##0.00"/></td>
                      <td>
                        <a href="${pageContext.request.contextPath}/payroll/slip/${p.payrollId}" class="btn btn-outline btn-sm" title="View Payslip">
                          <i class="bi bi-file-earmark-text"></i>
                        </a>
                        <c:if test="${role == 'ADMIN' || role == 'HR'}">
                        <form action="${pageContext.request.contextPath}/payroll/delete/${p.payrollId}" method="post"
                              data-confirm="Delete this payroll record?" style="display:inline;">
                          <button class="btn btn-ghost btn-sm" style="color:var(--danger);"><i class="bi bi-trash"></i></button>
                        </form>
                        </c:if>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
