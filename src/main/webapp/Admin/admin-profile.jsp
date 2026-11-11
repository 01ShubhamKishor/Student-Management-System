<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    if(session.getAttribute("admin") == null && !"ADMIN".equals(session.getAttribute("role")) ){
        response.sendRedirect(request.getContextPath()+ "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Home | StudentMS</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- SWEETALERT CDN ADDED -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        body{font-family:'Inter',sans-serif}
        .no-scrollbar::-webkit-scrollbar{display:none}
        .no-scrollbar{-ms-overflow-style:none;scrollbar-width:none}
    </style>
</head>
<body class="bg-[#f6f7fb] text-slate-900">

<!-- ADD + UPDATE POPUP - SESSION WALA -->
<% if(session.getAttribute("added") != null) { %>
<script>
Swal.fire({
  title: "Added!",
  text: "New admin added successfully",
  icon: "success",
  timer: 2000,
  showConfirmButton: false
});
</script>
<% session.removeAttribute("added"); %>
<% } %>

<% if(session.getAttribute("updated") != null) { %>
<script>
Swal.fire({
  title: "Updated!",
  text: "Admin profile updated successfully",
  icon: "success",
  timer: 2000,
  showConfirmButton: false
});
</script>
<% session.removeAttribute("updated"); %>
<% } %>

<!-- REQUEST WALA BHI SUPPORT (agar forward use karega to) -->
<% if(request.getAttribute("updated") != null) { %>
<script>
Swal.fire({
  title: "Updated!",
  text: "Admin profile updated successfully",
  icon: "success",
  timer: 2000,
  showConfirmButton: false
});
</script>
<% } %>

<div class="flex min-h-screen">
     <jsp:include page="sidebar.jsp"></jsp:include>
    
    <main class="flex-1 min-w-0">
      <div class="sticky top-0 z-10 bg-white/90 backdrop-blur border-b px-4 py-3 flex items-center justify-between">
        <div class="flex items-center gap-3">
          <button onclick="toggleSidebar()" class="lg:hidden w-9 h-9 grid place-items-center rounded-xl bg-slate-900 text-white">
            <i class="fa-solid fa-bars"></i>
          </button>
          <h2 class="font-bold text-[16px]">Admin Profile</h2>
        </div>
        <a href="${pageContext.request.contextPath}/GetAllStudents" class="text-xs bg-slate-900 text-white px-3 py-2 rounded-full">View Students</a>
      </div>

      <div class="p-4 lg:p-6 max-w-5xl mx-auto">
        <div class="bg-white rounded-[24px] border shadow-sm overflow-hidden">
         <div class="h-28 bg-gradient-to-r from-zinc-900 to-zinc-800"></div>
          <div class="p-5">
            <div class="flex flex-col sm:flex-row gap-4 -mt-12 sm:-mt-10 sm:items-end">
              <img src="https://i.pravatar.cc/120?img=12" class="w-20 h-20 rounded-2xl border-4 border-white shadow">
              <div class="flex-1">
                <h3 class="text-xl font-extrabold leading-none">${admin.user_name}</h3>
                <p class="text-sm text-slate-500 mt-1"><i class="fa-solid fa-envelope mr-1"></i> ${admin.email} • ${admin.role }</p>
              </div>
              <a href="${pageContext.request.contextPath}/LoadUpdateAdminProfile?id=${sessionScope.adminId}" class="inline-flex justify-center items-center gap-2 bg-slate-900 text-white px-5 py-2.5 rounded-xl text-sm">
                <i class="fa-solid fa-pen-to-square"></i> Edit Profile
              </a>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 gap-3 mt-6">
              <div class="bg-[#f6f7fb] rounded-2xl p-4">
                <p class="text-[11px] tracking-widest text-slate-400 font-bold">EMAIL</p>
                <p class="font-semibold mt-1 break-all">${admin.email}</p>
              </div>
              <div class="bg-[#f6f7fb] rounded-2xl p-4">
                <p class="text-[11px] tracking-widest text-slate-400 font-bold">CONTACT</p>
                <p class="font-semibold mt-1">+91 ${admin.contact}</p>
              </div>
              <div class="bg-[#f6f7fb] rounded-2xl p-4">
                <p class="text-[11px] tracking-widest text-slate-400 font-bold">ADDRESS</p>
                <p class="font-semibold mt-1">${admin.address}, India</p>
              </div>
              <div class="bg-[#f6f7fb] rounded-2xl p-4">
                <p class="text-[11px] tracking-widest text-slate-400 font-bold">DOB</p>
                <p class="font-semibold mt-1">${admin.dob}</p>
              </div>
            </div>
          </div>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-3 gap-3 mt-4">
          <div class="bg-white rounded-2xl border p-4 flex items-center gap-3">
            <div class="w-10 h-10 rounded-xl bg-indigo-50 grid place-items-center text-indigo-600"><i class="fa-solid fa-users"></i></div>
            <div><p class="font-bold leading-none">${totalActiveStudentCount}</p><p class="text-xs text-slate-500">Total Students</p></div>
          </div>
          <div class="bg-white rounded-2xl border p-4 flex items-center gap-3">
            <div class="w-10 h-10 rounded-xl bg-emerald-50 grid place-items-center text-emerald-600"><i class="fa-solid fa-user-check"></i></div>
            <div><p class="font-bold leading-none">Active</p><p class="text-xs text-slate-500">Account Status</p></div>
          </div>
          <div class="bg-white rounded-2xl border p-4 flex items-center gap-3">
            <div class="w-10 h-10 rounded-xl bg-amber-50 grid place-items-center text-amber-600"><i class="fa-solid fa-key"></i></div>
            <div><p class="font-bold leading-none">ADMIN</p><p class="text-xs text-slate-500">Role Access</p></div>
          </div>
        </div>
      </div>
    </main>
</div>

<script>
function toggleSidebar(){
    const s=document.getElementById('sidebar'), b=document.getElementById('sidebarBackdrop');
    if(s.classList.contains('-translate-x-full')){s.classList.remove('-translate-x-full');b.classList.remove('hidden');}
    else{s.classList.add('-translate-x-full');b.classList.add('hidden');}
}
</script>
</body>
</html>