<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Login — Smart HRMS</title>
  <%@ include file="/WEB-INF/views/common/head.jsp" %>
</head>
<body>
<div class="login-page">
  <div class="login-card fade-in">
    <div class="login-logo">
      <div class="logo-icon">🏢</div>
      <h4>Smart HRMS</h4>
      <p>Sign in to your account to continue</p>
    </div>

    <c:if test="${not empty errorMsg}">
      <div class="alert alert-danger mb-3">
        <i class="bi bi-exclamation-triangle-fill"></i> ${errorMsg}
      </div>
    </c:if>
    <c:if test="${not empty logoutMsg}">
      <div class="alert alert-success mb-3">
        <i class="bi bi-check-circle-fill"></i> ${logoutMsg}
      </div>
    </c:if>

    <form method="POST" action="${pageContext.request.contextPath}/login">
      <div class="form-group">
        <label class="form-label">Email Address</label>
        <div style="position:relative;">
          <i class="bi bi-envelope" style="position:absolute;left:13px;top:50%;transform:translateY(-50%);color:#94a3b8;"></i>
          <input type="email" name="email" class="form-control" placeholder="you@company.com"
                 style="padding-left:38px;" required autofocus>
        </div>
      </div>

      <div class="form-group">
        <label class="form-label">Password</label>
        <div style="position:relative;">
          <i class="bi bi-lock" style="position:absolute;left:13px;top:50%;transform:translateY(-50%);color:#94a3b8;"></i>
          <input type="password" name="password" id="passwordField" class="form-control" placeholder="Enter password"
                 style="padding-left:38px;" required>
          <button type="button" onclick="togglePwd()" style="position:absolute;right:12px;top:50%;transform:translateY(-50%);background:none;border:none;cursor:pointer;color:#94a3b8;">
            <i class="bi bi-eye" id="eyeIcon"></i>
          </button>
        </div>
      </div>

      <button type="submit" class="login-btn">
        Sign In &nbsp;<i class="bi bi-arrow-right"></i>
      </button>
    </form>

    <div class="text-center mt-3" style="color:#94a3b8;font-size:12px;">
      Smart HRMS &copy; ${java.time.Year.now().value} &mdash; All rights reserved
    </div>
  </div>
</div>

<script>
function togglePwd() {
  var f = document.getElementById('passwordField');
  var i = document.getElementById('eyeIcon');
  if (f.type === 'password') {
    f.type = 'text'; i.className = 'bi bi-eye-slash';
  } else {
    f.type = 'password'; i.className = 'bi bi-eye';
  }
}
</script>
</body>
</html>
