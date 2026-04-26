<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Meeting Details — Smart HRMS</title>
  <%@ include file="/WEB-INF/views/common/head.jsp" %>
</head>
<body>
<div class="wrapper">
  <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
  <div class="main-content">
    <c:set var="pageTitle" value="Meeting Details" />
    <%@ include file="/WEB-INF/views/common/topbar.jsp" %>
    <div class="page-body fade-in">
      <%@ include file="/WEB-INF/views/common/alerts.jsp" %>

      <div class="row g-4">
        <div class="col-lg-7">
          <div class="card mb-4">
            <div class="card-header">
              <h5><i class="bi bi-camera-video-fill text-primary me-2"></i>${meeting.title}</h5>
              <a href="${pageContext.request.contextPath}/meetings" class="btn btn-outline btn-sm"><i class="bi bi-arrow-left"></i> Back</a>
            </div>
            <div class="card-body">
              <div class="row g-3">
                <div class="col-sm-6">
                  <div class="text-muted small mb-1">Scheduled At</div>
                  <div class="fw-600">${meeting.scheduledAt}</div>
                </div>
                <div class="col-sm-6">
                  <div class="text-muted small mb-1">Organized By</div>
                  <div class="fw-600">${meeting.createdBy.firstName} ${meeting.createdBy.lastName}</div>
                </div>
              </div>
              <hr style="border-color:var(--border);margin:16px 0;">
              <div class="text-muted small mb-2">Attendees (${meeting.attendees.size()})</div>
              <div style="display:flex;flex-wrap:wrap;gap:8px;">
                <c:forEach var="att" items="${meeting.attendees}">
                  <div style="display:flex;align-items:center;gap:6px;padding:6px 12px;background:#f8fafc;border-radius:20px;font-size:12px;font-weight:500;">
                    <div class="avatar" style="width:24px;height:24px;font-size:10px;">${att.firstName.substring(0,1)}${att.lastName.substring(0,1)}</div>
                    ${att.firstName} ${att.lastName}
                  </div>
                </c:forEach>
              </div>
            </div>
          </div>

          <!-- MOM Section -->
          <div class="card">
            <div class="card-header">
              <h5><i class="bi bi-journal-text text-primary me-2"></i>Minutes of Meeting (MOM)</h5>
            </div>
            <div class="card-body">
              <c:choose>
                <c:when test="${mom != null && not empty mom.notes}">
                  <div style="background:#f8fafc;border-left:4px solid var(--primary);padding:16px;border-radius:0 8px 8px 0;white-space:pre-line;font-size:13.5px;">
                    ${mom.notes}
                  </div>
                  <c:if test="${role == 'ADMIN' || role == 'HR' || role == 'MANAGER'}">
                  <div class="mt-3">
                    <button onclick="document.getElementById('momEditForm').style.display='block';this.style.display='none';"
                            class="btn btn-outline btn-sm"><i class="bi bi-pencil"></i> Edit MOM</button>
                  </div>
                  </c:if>
                </c:when>
                <c:otherwise>
                  <div class="text-muted small mb-3">No MOM added yet.</div>
                </c:otherwise>
              </c:choose>

              <c:if test="${role == 'ADMIN' || role == 'HR' || role == 'MANAGER'}">
              <form action="${pageContext.request.contextPath}/meetings/mom/${meeting.meetingId}" method="post"
                    id="momEditForm" style="${mom != null && not empty mom.notes ? 'display:none;' : ''}">
                <div class="form-group">
                  <label class="form-label">Add / Update MOM Notes</label>
                  <textarea name="notes" class="form-control" rows="6"
                            placeholder="Enter meeting notes, decisions, action items...">${mom != null ? mom.notes : ''}</textarea>
                </div>
                <div class="d-flex gap-2 justify-content-end">
                  <button type="submit" class="btn btn-primary"><i class="bi bi-save"></i> Save MOM</button>
                </div>
              </form>
              </c:if>
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
