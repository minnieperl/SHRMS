<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:if test="${not empty success}">
  <div class="alert alert-success fade-in" data-auto-dismiss>
    <i class="bi bi-check-circle-fill"></i>
    <span>${success}</span>
  </div>
</c:if>
<c:if test="${not empty error}">
  <div class="alert alert-danger fade-in" data-auto-dismiss>
    <i class="bi bi-exclamation-triangle-fill"></i>
    <span>${error}</span>
  </div>
</c:if>
