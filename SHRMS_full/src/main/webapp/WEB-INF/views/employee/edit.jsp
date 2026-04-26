<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Edit Employee — Smart HRMS</title>
  <%@ include file="/WEB-INF/views/common/head.jsp" %>
</head>
<body>
<div class="wrapper">
  <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
  <div class="main-content">
    <c:set var="pageTitle" value="Edit Employee" />
    <%@ include file="/WEB-INF/views/common/topbar.jsp" %>
    <div class="page-body fade-in">
      <%@ include file="/WEB-INF/views/common/alerts.jsp" %>

      <div class="row justify-content-center">
        <div class="col-xl-9">
          <div class="card">
            <div class="card-header">
              <h5><i class="bi bi-pencil-fill text-primary me-2"></i>Edit: ${editEmployee.firstName} ${editEmployee.lastName}</h5>
              <a href="${pageContext.request.contextPath}/employees" class="btn btn-outline btn-sm">
                <i class="bi bi-arrow-left"></i> Back
              </a>
            </div>
            <div class="card-body">
              <form action="${pageContext.request.contextPath}/employees/edit/${editEmployee.employeeId}"
                    method="post" enctype="multipart/form-data">

                <!-- Current photo -->
                <div class="text-center mb-4">
                  <c:choose>
                    <c:when test="${not empty editEmployee.photoPath}">
                      <img src="${pageContext.request.contextPath}/uploads/${editEmployee.photoPath}"
                           id="photoPreview"
                           style="width:96px;height:96px;border-radius:50%;object-fit:cover;border:3px solid var(--primary-light);">
                    </c:when>
                    <c:otherwise>
                      <div id="photoPreview" style="width:96px;height:96px;border-radius:50%;background:var(--primary-light);display:inline-flex;align-items:center;justify-content:center;font-size:34px;font-weight:700;color:var(--primary);">
                        ${editEmployee.firstName.substring(0,1)}${editEmployee.lastName.substring(0,1)}
                      </div>
                    </c:otherwise>
                  </c:choose>
                  <div class="mt-2">
                    <label class="btn btn-outline btn-sm" style="cursor:pointer;">
                      <i class="bi bi-camera"></i> Change Photo
                      <input type="file" name="photo" id="photoInput" accept="image/*" style="display:none;">
                    </label>
                  </div>
                </div>

                <div class="row g-3">
                  <div class="col-md-6">
                    <div class="form-group">
                      <label class="form-label">First Name *</label>
                      <input type="text" name="firstName" class="form-control" value="${editEmployee.firstName}" required>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="form-group">
                      <label class="form-label">Last Name *</label>
                      <input type="text" name="lastName" class="form-control" value="${editEmployee.lastName}" required>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="form-group">
                      <label class="form-label">Email Address *</label>
                      <input type="email" name="email" class="form-control" value="${editEmployee.email}" required>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="form-group">
                      <label class="form-label">Phone</label>
                      <input type="text" name="phone" class="form-control" value="${editEmployee.phone}">
                    </div>
                  </div>
                  <div class="col-md-4">
                    <div class="form-group">
                      <label class="form-label">Role *</label>
                      <select name="roleId" class="form-select" required>
                        <c:forEach var="r" items="${roles}">
                          <option value="${r.roleId}" ${editEmployee.role.roleId == r.roleId ? 'selected' : ''}>${r.roleName}</option>
                        </c:forEach>
                      </select>
                    </div>
                  </div>
                  <div class="col-md-4">
                    <div class="form-group">
                      <label class="form-label">Department *</label>
                      <select name="departmentId" class="form-select" required>
                        <c:forEach var="d" items="${departments}">
                          <option value="${d.departmentId}" ${editEmployee.department.departmentId == d.departmentId ? 'selected' : ''}>${d.departmentName}</option>
                        </c:forEach>
                      </select>
                    </div>
                  </div>
                  <div class="col-md-4">
                    <div class="form-group">
                      <label class="form-label">Reporting Manager</label>
                      <select name="managerId" class="form-select">
                        <option value="">No Manager</option>
                        <c:forEach var="m" items="${managers}">
                          <option value="${m.employeeId}"
                            ${editEmployee.manager != null && editEmployee.manager.employeeId == m.employeeId ? 'selected' : ''}>
                            ${m.firstName} ${m.lastName} (${m.role.roleName})
                          </option>
                        </c:forEach>
                      </select>
                    </div>
                  </div>
                  <div class="col-md-4">
                    <div class="form-group">
                      <label class="form-label">Joining Date</label>
                      <input type="date" name="joiningDate" class="form-control" value="${editEmployee.joiningDate}">
                    </div>
                  </div>
                  <div class="col-md-4">
                    <div class="form-group">
                      <label class="form-label">Base Salary (₹)</label>
                      <input type="number" name="baseSalary" class="form-control" value="${editEmployee.baseSalary}" step="0.01">
                    </div>
                  </div>
                  <div class="col-md-4">
                    <div class="form-group">
                      <label class="form-label">Status</label>
                      <select name="status" class="form-select">
                        <option value="ACTIVE" ${editEmployee.status == 'ACTIVE' ? 'selected' : ''}>ACTIVE</option>
                        <option value="INACTIVE" ${editEmployee.status == 'INACTIVE' ? 'selected' : ''}>INACTIVE</option>
                      </select>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="form-group">
                      <label class="form-label">New Password <span class="text-muted small">(leave blank to keep current)</span></label>
                      <input type="password" name="password" class="form-control" placeholder="Enter new password">
                    </div>
                  </div>
                </div>

                <div class="d-flex justify-content-end gap-2 mt-4">
                  <a href="${pageContext.request.contextPath}/employees" class="btn btn-outline">Cancel</a>
                  <button type="submit" class="btn btn-primary">
                    <i class="bi bi-check-lg"></i> Save Changes
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
</body>
</html>
