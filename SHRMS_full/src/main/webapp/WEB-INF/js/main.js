// Smart HRMS - Main JS

document.addEventListener('DOMContentLoaded', function () {

  // ── Auto-dismiss alerts after 4s ──
  document.querySelectorAll('.alert[data-auto-dismiss]').forEach(function (el) {
    setTimeout(function () {
      el.style.transition = 'opacity 0.4s';
      el.style.opacity = '0';
      setTimeout(function () { el.remove(); }, 400);
    }, 4000);
  });

  // ── Confirm delete forms ──
  document.querySelectorAll('form[data-confirm]').forEach(function (form) {
    form.addEventListener('submit', function (e) {
      var msg = form.dataset.confirm || 'Are you sure?';
      if (!confirm(msg)) e.preventDefault();
    });
  });

  // ── Sidebar toggle (mobile) ──
  var sidebarToggle = document.getElementById('sidebarToggle');
  var sidebar = document.querySelector('.sidebar');
  if (sidebarToggle && sidebar) {
    sidebarToggle.addEventListener('click', function () {
      sidebar.classList.toggle('open');
    });
  }

  // ── Active nav link ──
  var currentPath = window.location.pathname;
  document.querySelectorAll('.sidebar-nav .nav-link').forEach(function (link) {
    if (link.getAttribute('href') && currentPath.startsWith(link.getAttribute('href'))) {
      link.classList.add('active');
    }
  });

  // ── Photo preview ──
  var photoInput = document.getElementById('photoInput');
  var photoPreview = document.getElementById('photoPreview');
  if (photoInput && photoPreview) {
    photoInput.addEventListener('change', function () {
      var file = this.files[0];
      if (file) {
        var reader = new FileReader();
        reader.onload = function (e) { photoPreview.src = e.target.result; photoPreview.style.display = 'block'; };
        reader.readAsDataURL(file);
      }
    });
  }

  // ── Tooltip init (Bootstrap) ──
  if (typeof bootstrap !== 'undefined') {
    document.querySelectorAll('[data-bs-toggle="tooltip"]').forEach(function (el) {
      new bootstrap.Tooltip(el);
    });
  }

  // ── Print payslip ──
  var printBtn = document.getElementById('printPayslip');
  if (printBtn) {
    printBtn.addEventListener('click', function () { window.print(); });
  }
});
