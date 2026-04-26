<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Error — Smart HRMS</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
  <style>
    body { background: #f1f5f9; display: flex; align-items: center; justify-content: center; min-height: 100vh; font-family: 'Segoe UI', sans-serif; }
    .error-card { background: #fff; border-radius: 16px; padding: 48px 40px; max-width: 480px; width: 100%; text-align: center; box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
  </style>
</head>
<body>
<div class="error-card">
  <div style="font-size:64px;margin-bottom:16px;">⚠️</div>
  <h3 style="font-weight:800;color:#1e293b;margin-bottom:8px;">Something went wrong</h3>
  <p style="color:#64748b;margin-bottom:8px;">${errorMessage}</p>
  <p style="color:#94a3b8;font-size:12px;margin-bottom:24px;">${requestUri}</p>
  <a href="/dashboard" style="display:inline-block;background:#4f46e5;color:#fff;padding:10px 24px;border-radius:8px;text-decoration:none;font-weight:600;">
    ← Back to Dashboard
  </a>
</div>
</body>
</html>
