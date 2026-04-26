<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Access Denied — Smart HRMS</title>
  <style>
    body { background: #f1f5f9; display: flex; align-items: center; justify-content: center; min-height: 100vh; font-family: 'Segoe UI', sans-serif; }
    .error-card { background: #fff; border-radius: 16px; padding: 48px 40px; max-width: 480px; width: 100%; text-align: center; box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
  </style>
</head>
<body>
<div class="error-card">
  <div style="font-size:64px;margin-bottom:16px;">🔒</div>
  <h3 style="font-weight:800;color:#1e293b;margin-bottom:8px;">Access Denied</h3>
  <p style="color:#64748b;margin-bottom:24px;">${errorMessage}</p>
  <a href="/dashboard" style="display:inline-block;background:#4f46e5;color:#fff;padding:10px 24px;border-radius:8px;text-decoration:none;font-weight:600;">
    ← Back to Dashboard
  </a>
</div>
</body>
</html>
