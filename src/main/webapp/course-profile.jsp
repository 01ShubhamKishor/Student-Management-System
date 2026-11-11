<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    if(session.getAttribute("admin") == null){
        response.sendRedirect(request.getContextPath()+ "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Course Profile | StudentMS</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>body{font-family:'Inter',sans-serif}</style>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body class="bg-[#f6f7fb] text-slate-900">

<!-- POPUP - ADD COURSE -->
<% if(request.getAttribute("added") != null) { %>
<script>
Swal.fire({
  title: "Added!",
  text: "Course added successfully",
  icon: "success",
  timer: 2000,
  showConfirmButton: false
});
</script>
<% } %>

<!-- POPUP - UPDATE COURSE -->
<% if(request.getAttribute("updated") != null) { %>
<script>
Swal.fire({
  title: "Updated!",
  text: "Course updated successfully",
  icon: "success",
  timer: 2000,
  showConfirmButton: false
});
</script>
<% } %>

<!-- SESSION WALA BHI (agar redirect use karega to) -->
<% if(session.getAttribute("added") != null) { %>
<script>
Swal.fire({
  title: "Added!",
  text: "Course added successfully",
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
  text: "Course updated successfully",
  icon: "success",
  timer: 2000,
  showConfirmButton: false
});
</script>
<% session.removeAttribute("updated"); %>
<% } %>

<div class="flex min-h-screen">
    <jsp:include page="/Admin/sidebar.jsp" />
    
    <main class="flex-1 min-w-0">
      <div class="sticky top-0 z-10 bg-white/90 backdrop-blur border-b px-4 py-3 flex items-center justify-between">
        <div class="flex items-center gap-3">
          <button onclick="toggleSidebar()" class="lg:hidden w-9 h-9 grid place-items-center rounded-xl bg-slate-900 text-white">
            <i class="fa-solid fa-bars"></i>
          </button>
          <h2 class="font-bold text-[16px]">Course Profile</h2>
        </div>
        <a href="${pageContext.request.contextPath}/courses" class="text-xs bg-slate-900 text-white px-3 py-2 rounded-full"><i class="fa-solid fa-arrow-left mr-1"></i> Back to List</a>
      </div>

      <div class="p-4 lg:p-6 max-w-5xl mx-auto">
        <div class="bg-white rounded-[24px] border shadow-sm overflow-hidden">
          
          <div class="h-22 bg-[#0f172a] relative overflow-hidden">
            <div class="absolute inset-0 bg-gradient-to-r from-cyan-400/20 via-blue-500/20 to-indigo-500/20"></div>
            <div class="absolute -right-16 -top-16 w-60 h-60 bg-indigo-500/20 rounded-full blur-3xl"></div>
            <div class="absolute -left-10 -bottom-10 w-40 h-40 bg-cyan-400/10 rounded-full blur-2xl"></div>
            
           <div class="relative p-6 flex flex-col gap-2">
            <div class="flex justify-between items-start">
              <div class="flex items-center gap-2">
                   <div class="w-12 h-12 rounded-xl bg-white text-slate-900 grid place-items-center text-xl shadow-lg">
                    <i class="fa-solid fa-graduation-cap"></i>
                       </div>
                    <div class="text-white">
                     <p class="text-[12px] tracking-[0.25em] opacity-50 font-bold">COURSE OVERVIEW</p>
                     <p class="font-bold text-sm tracking-wide">${course.department}</p>
                 </div>
                   </div>
             <span class="inline-flex items-center gap-1.5 text-[11px] font-bold px-3 py-1.5 rounded-full bg-white/10 text-white border border-white/10 backdrop-blur">
               <span class="w-2 h-2 rounded-full ${course.active ? 'bg-emerald-400' : 'bg-red-400'} animate-pulse"></span> ${course.active ? 'ACTIVE' : 'INACTIVE'}
            </span>
           </div>
</div>
</div>

          <div class="p-5">
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3">
              <div class="bg-[#f6f7fb] rounded-2xl p-4 border border-transparent hover:border-slate-200 transition">
                <p class="text-[11px] tracking-widest text-slate-400 font-bold flex items-center gap-2"><i class="fa-solid fa-hashtag"></i> COURSE CODE</p>
                <p class="font-semibold mt-1">${course.course_code}</p>
              </div>
              <div class="bg-[#f6f7fb] rounded-2xl p-4 border border-transparent hover:border-slate-200 transition">
                <p class="text-[11px] tracking-widest text-slate-400 font-bold flex items-center gap-2"><i class="fa-solid fa-book"></i> COURSE NAME</p>
                <p class="font-semibold mt-1">${course.course}</p>
              </div>
              <div class="bg-[#f6f7fb] rounded-2xl p-4 border border-transparent hover:border-slate-200 transition">
                <p class="text-[11px] tracking-widest text-slate-400 font-bold flex items-center gap-2"><i class="fa-solid fa-building-columns"></i> DEPARTMENT</p>
                <p class="font-semibold mt-1">${course.department}</p>
              </div>
              <div class="bg-slate-900 text-white rounded-2xl p-4">
                <p class="text-[11px] tracking-widest text-white/50 font-bold">FEE</p>
                <p class="font-bold mt-1 text-lg">₹ <fmt:formatNumber value="${course.fee}" pattern="#,##0.00" /></p>
              </div>
              <div class="bg-[#f6f7fb] rounded-2xl p-4">
                <p class="text-[11px] tracking-widest text-slate-400 font-bold">DURATION</p>
                <p class="font-semibold mt-1">${course.duration_year} Years</p>
              </div>
              <div class="bg-[#f6f7fb] rounded-2xl p-4">
                <p class="text-[11px] tracking-widest text-slate-400 font-bold">TOTAL SEMESTER</p>
                <p class="font-semibold mt-1">${course.total_semester} Semesters</p>
              </div>
              <div class="bg-[#f6f7fb] rounded-2xl p-4 sm:col-span-2 lg:col-span-3">
                <p class="text-[11px] tracking-widest text-slate-400 font-bold">DESCRIPTION</p>
                <p class="font-medium mt-1 text-sm leading-relaxed text-slate-600">${course.description}</p>
              </div>
            </div>

            <div class="flex gap-3 mt-6">
              <a href="${pageContext.request.contextPath}/EditCourse?id=${course.id}" class="flex-1 inline-flex justify-center items-center gap-2 bg-slate-900 text-white px-5 py-3 rounded-xl text-sm font-bold hover:bg-black transition">
                <i class="fa-solid fa-pen-to-square"></i> Edit Course
              </a>
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