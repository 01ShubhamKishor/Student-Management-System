<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    String role = (String) session.getAttribute("role");
    if(role == null || (!"STUDENT".equals(role))){
        response.sendRedirect(request.getContextPath()+"/login.jsp");
       return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Profile | StudentMS</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>body{font-family:'Inter',sans-serif} .no-scrollbar::-webkit-scrollbar{display:none} .no-scrollbar{-ms-overflow-style:none;scrollbar-width:none}</style>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body class="bg-[#f6f7fb] text-slate-900">

<div class="flex min-h-screen">
    <jsp:include page="student-sidebar.jsp" />
    <main class="flex-1 min-w-0">
      <div class="sticky top-0 z-10 bg-white/90 backdrop-blur border-b px-4 py-3 flex items-center justify-between">
        <div class="flex items-center gap-3">
          <button onclick="toggleSidebar()" class="lg:hidden w-9 h-9 grid place-items-center rounded-xl bg-slate-900 text-white">
            <i class="fa-solid fa-bars"></i>
          </button>
          <h2 class="font-bold text-[16px]">Student Profile</h2>
        </div>
        <a href="student-dashboard.jsp" class="text-xs bg-slate-900 text-white px-3 py-2 rounded-full">Back to Dashboard</a>
      </div>

      <div class="p-4 lg:p-6 max-w-5xl mx-auto">
        <div class="bg-white rounded-[24px] border shadow-sm overflow-hidden">
          <div class="h-28 bg-gradient-to-r from-slate-900 via-slate-800 to-indigo-700"></div>
          <div class="p-5">
            <div class="flex flex-col sm:flex-row gap-4 -mt-12 sm:-mt-10 sm:items-end">
              <div class="w-20 h-20 rounded-2xl border-4 border-white shadow bg-slate-900 text-white grid place-items-center text-2xl font-extrabold">
                ${student.full_name.substring(0,1)}
              </div>
              <div class="flex-1">
                <h3 class="text-xl font-extrabold leading-none">${student.full_name}</h3>
                <p class="text-sm text-slate-500 mt-1"><i class="fa-solid fa-id-badge mr-1"></i> ${student.roll_number} • ${student.course_code} - Sem ${student.semester}</p>
              </div>
              <div class="flex gap-2">
                <span class="inline-flex items-center gap-1.5 text-xs font-bold px-3 py-1.5 rounded-full ${student.status == 'ACTIVE' ? 'bg-emerald-50 text-emerald-600' : student.status == 'PASSOUT' ? 'bg-blue-50 text-blue-600' : 'bg-red-50 text-red-600'}">
                    <span class="w-2 h-2 rounded-full ${student.status == 'ACTIVE' ? 'bg-emerald-500' : student.status == 'PASSOUT' ? 'bg-blue-500' : 'bg-red-500'}"></span> ${student.status}
                </span>
              </div>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 gap-3 mt-6">
              <div class="bg-[#f6f7fb] rounded-2xl p-4">
                <p class="text-[11px] tracking-widest text-slate-400 font-bold">FULL NAME</p>
                <p class="font-semibold mt-1">${student.full_name}</p>
              </div>
              <div class="bg-[#f6f7fb] rounded-2xl p-4">
                <p class="text-[11px] tracking-widest text-slate-400 font-bold">ROLL NUMBER</p>
                <p class="font-semibold mt-1">${student.roll_number}</p>
              </div>
              <div class="bg-[#f6f7fb] rounded-2xl p-4">
                <p class="text-[11px] tracking-widest text-slate-400 font-bold">EMAIL</p>
                <p class="font-semibold mt-1 break-all">${student.email}</p>
              </div>
              <div class="bg-[#f6f7fb] rounded-2xl p-4">
                <p class="text-[11px] tracking-widest text-slate-400 font-bold">PHONE</p>
                <p class="font-semibold mt-1">+91 ${student.phone}</p>
              </div>
              <div class="bg-[#f6f7fb] rounded-2xl p-4">
                <p class="text-[11px] tracking-widest text-slate-400 font-bold">DOB</p>
                <p class="font-semibold mt-1">${student.dob}</p>
              </div>
              <div class="bg-[#f6f7fb] rounded-2xl p-4">
                <p class="text-[11px] tracking-widest text-slate-400 font-bold">COURSE / SEMESTER</p>
                <p class="font-semibold mt-1">${student.course_code} - Semester ${student.semester}</p>
              </div>

              <div class="bg-[#f6f7fb] rounded-2xl p-4 sm:col-span-2">
                <p class="text-[11px] tracking-widest text-slate-400 font-bold">ADDRESS</p>
                <p class="font-semibold mt-1">${student.address}</p>
              </div>
            </div>
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