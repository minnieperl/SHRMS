<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Add Employee — Smart HRMS</title>
  <%@ include file="/WEB-INF/views/common/head.jsp" %>
</head>
<body>
<div class="wrapper">
  <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
  <div class="main-content">
    <c:set var="pageTitle" value="Add Employee" />
    <%@ include file="/WEB-INF/views/common/topbar.jsp" %>
    <div class="page-body fade-in">
      <%@ include file="/WEB-INF/views/common/alerts.jsp" %>

      <div class="row justify-content-center">
        <div class="col-xl-9">
          <div class="card">
            <div class="card-header">
              <h5><i class="bi bi-person-plus-fill text-primary me-2"></i>New Employee Registration</h5>
              <a href="${pageContext.request.contextPath}/employees" class="btn btn-outline btn-sm">
                <i class="bi bi-arrow-left"></i> Back
              </a>
            </div>
            <div class="card-body">
              <form action="${pageContext.request.contextPath}/employees/add"
                    method="post" enctype="multipart/form-data">

                <!-- Photo Upload -->
                <div class="text-center mb-4">
                  <div style="position:relative;display:inline-block;">
                    <img id="photoPreview" src="" alt="Photo Preview"
                         style="width:96px;height:96px;border-radius:50%;object-fit:cover;border:3px solid var(--primary-light);display:none;">
                    <div id="photoPlaceholder" style="width:96px;height:96px;border-radius:50%;background:var(--primary-light);display:flex;align-items:center;justify-content:center;font-size:36px;cursor:pointer;border:3px dashed var(--primary);">
                      👤
                    </div>
                  </div>
                  <div class="mt-2">
                    <label class="btn btn-outline btn-sm" style="cursor:pointer;">
                      <i class="bi bi-camera"></i> Upload Photo
                      <input type="file" name="photo" id="photoInput" accept="image/*" style="display:none;">
                    </label>
                  </div>
                </div>

                <div class="row g-3">
                  <div class="col-md-6">
                    <div class="form-group">
                      <label class="form-label">First Name *</label>
                      <input type="text" name="firstName" class="form-control" placeholder="John" required>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="form-group">
                      <label class="form-label">Last Name *</label>
                      <input type="text" name="lastName" class="form-control" placeholder="Doe" required>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="form-group">
                      <label class="form-label">Email Address *</label>
                      <input type="email" name="email" class="form-control" placeholder="john@company.com" required>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="form-group">
                      <label class="form-label">Phone</label>
                      <input type="text" name="phone" class="form-control" placeholder="+91 9876543210">
                    </div>
                  </div>
                  <div class="col-md-4">
                    <div class="form-group">
                      <label class="form-label">Role *</label>
                      <select name="roleId" class="form-select" required>
                        <option value="">Select Role</option>
                        <c:forEach var="r" items="${roles}">
                          <option value="${r.roleId}">${r.roleName}</option>
                        </c:forEach>
                      </select>
                    </div>
                  </div>
                  <div class="col-md-4">
                    <div class="form-group">
                      <label class="form-label">Department *</label>
                      <select name="departmentId" class="form-select" required>
                        <option value="">Select Department</option>
                        <c:forEach var="d" items="${departments}">
                          <option value="${d.departmentId}">${d.departmentName}</option>
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
                          <option value="${m.employeeId}">${m.firstName} ${m.lastName} (${m.role.roleName})</option>
                        </c:forEach>
                      </select>
                    </div>
                  </div>
                  <div class="col-md-4">
                    <div class="form-group">
                      <label class="form-label">Joining Date</label>
                      <input type="date" name="joiningDate" class="form-control">
                    </div>
                  </div>
                  <div class="col-md-4">
                    <div class="form-group">
                      <label class="form-label">Base Salary (₹)</label>
                      <input type="number" name="baseSalary" class="form-control" placeholder="50000" step="0.01">
                    </div>
                  </div>
                  <div class="col-md-4">
                    <div class="form-group">
                      <label class="form-label">Password</label>
                      <input type="password" name="password" class="form-control" placeholder="Leave blank = EmpCode">
                    </div>
                  </div>
                </div>

                <div class="d-flex justify-content-end gap-2 mt-4">
                  <a href="${pageContext.request.contextPath}/employees" class="btn btn-outline">Cancel</a>
                  <button type="submit" class="btn btn-primary">
                    <i class="bi bi-person-check"></i> Create Employee
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
document.getElementById('photoInput').addEventListener('change', function () {
  var file = this.files[0];
  if (file) {
    var r = new FileReader();
    r.onload = function (e) {
      var prev = document.getElementById('photoPreview');
      var placeholder = document.getElementById('photoPlaceholder');
      prev.src = e.target.result;
      prev.style.display = 'block';
      placeholder.style.display = 'none';
    };
    r.readAsDataURL(file);
  }
});
</script>
</body>
</html>
