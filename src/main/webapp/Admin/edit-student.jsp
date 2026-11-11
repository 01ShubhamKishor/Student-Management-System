<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>Edit Student | StudentMS</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>body{font-family:'Inter',sans-serif}</style>
</head>
<body class="bg-[#f6f7fb] text-slate-900">

<div class="flex min-h-screen">
    <jsp:include page="/Admin/sidebar.jsp" />

    <main class="flex-1 min-w-0">
      <div class="sticky top-0 z-10 bg-white/90 backdrop-blur border-b px-4 py-3 flex items-center justify-between">
        <div class="flex items-center gap-3">
          <button onclick="toggleSidebar()" class="lg:hidden w-9 h-9 grid place-items-center rounded-xl bg-slate-900 text-white"><i class="fa-solid fa-bars"></i></button>
          <h2 class="font-bold text-[16px]">Edit Student</h2>
        </div>
        <a href="${pageContext.request.contextPath}/student-profile.jsp" class="text-xs bg-white border px-3 py-2 rounded-full">Back</a>
      </div>

      <div class="p-4 lg:p-6 max-w-5xl mx-auto">
        <form action="${pageContext.request.contextPath}/UpdateStudent?id=${ustudent.id}" method="post" class="bg-white rounded-[24px] border shadow-sm p-5 lg:p-6">
          
          <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
            
            <div class="sm:col-span-2">
                <label class="text-[11px] font-bold tracking-widest text-slate-400">FULL NAME</label>
                <input type="text" name="FULL_NAME" value="${ustudent.full_name}" required class="mt-1 w-full bg-[#f6f7fb] border rounded-xl px-4 py-2.5 text-sm font-semibold focus:outline-none focus:ring-2 focus:ring-indigo-500">
            </div>

            <div>
                <label class="text-[11px] font-bold tracking-widest text-slate-400">ROLL NUMBER</label>
                <input type="text" name="ROLL_NUMBER" value="${ustudent.roll_number}" required class="mt-1 w-full bg-slate-100 border rounded-xl px-4 py-2.5 text-sm font-semibold text-slate-500">
            </div>

            <div>
                <label class="text-[11px] font-bold tracking-widest text-slate-400">EMAIL</label>
                <input type="email" name="EMAIL" value="${ustudent.email}" required class="mt-1 w-full bg-[#f6f7fb] border rounded-xl px-4 py-2.5 text-sm font-semibold">
            </div>

            <div>
                <label class="text-[11px] font-bold tracking-widest text-slate-400">PHONE</label>
                <input type="text" name="PHONE" value="${ustudent.phone}" required class="mt-1 w-full bg-[#f6f7fb] border rounded-xl px-4 py-2.5 text-sm font-semibold">
            </div>

            <div>
                <label class="text-[11px] font-bold tracking-widest text-slate-400">DOB</label>
                <input type="date" name="DOB" value="${ustudent.dob}" required  class="mt-1 w-full bg-[#f6f7fb] border rounded-xl px-4 py-2.5 text-sm font-semibold">
            </div>

            <!-- FIXED: COURSE_CODE -->
            <div>
                <label class="text-[11px] font-bold tracking-widest text-slate-400">COURSE CODE *</label>
                <input type="text" name="COURSE_CODE" value="${ustudent.course_code}" required  class="mt-1 w-full bg-[#f6f7fb] border rounded-xl px-4 py-2.5 text-sm font-semibold focus:outline-none focus:ring-2 focus:ring-indigo-500">
            </div>

            <div>
                <label class="text-[11px] font-bold tracking-widest text-slate-400">SEMESTER</label>
                <input type="number" name="SEMESTER" value="${ustudent.semester}" required  class="mt-1 w-full bg-[#f6f7fb] border rounded-xl px-4 py-2.5 text-sm font-semibold">
            </div>

            <div>
                <label class="text-[11px] font-bold tracking-widest text-slate-400">ADMISSION YEAR *</label>
                <input type="number" name="ADMISSION_YEAR" value="${ustudent.admissionYear}" min="2000" max="2030" required class="mt-1 w-full bg-[#f6f7fb] border rounded-xl px-4 py-2.5 text-sm font-semibold focus:outline-none focus:ring-2 focus:ring-indigo-500">
                <p class="text-[10px] text-slate-400 mt-1">2000-2030 only</p>
            </div>

            <div>
                <label class="text-[11px] font-bold tracking-widest text-slate-400">STATUS *</label>
                <select name="STATUS" class="mt-1 w-full bg-[#f6f7fb] border rounded-xl px-4 py-2.5 text-sm font-semibold">
                    <option value="ACTIVE" ${ustudent.status == 'ACTIVE' ? 'selected' : ''}>ACTIVE</option>
                    <option value="PASSOUT" ${ustudent.status == 'PASSOUT' ? 'selected' : ''}>PASSOUT</option>
                    <option value="DROPOUT" ${ustudent.status == 'DROPOUT' ? 'selected' : ''}>DROPOUT</option>
                </select>
            </div>

            <div>
                <label class="text-[11px] font-bold tracking-widest text-slate-400">PASSWORD</label>
                <input type="text" name="PASSWORD" value="${ustudent.password}" required  class="mt-1 w-full bg-[#f6f7fb] border rounded-xl px-4 py-2.5 text-sm font-semibold">
            </div>

            <div class="sm:col-span-2">
                <label class="text-[11px] font-bold tracking-widest text-slate-400">ADDRESS</label>
                <textarea name="ADDRESS" rows="3" required  class="mt-1 w-full bg-[#f6f7fb] border rounded-xl px-4 py-2.5 text-sm font-semibold">${ustudent.address}</textarea>
            </div>

          </div>

          <div class="mt-6 flex gap-3">
            <button type="submit" class="flex-1 sm:flex-none bg-slate-900 text-white px-8 py-3 rounded-xl text-sm font-bold"><i class="fa-solid fa-floppy-disk mr-2"></i> Update Student</button>
            <a href="${pageContext.request.contextPath}/GetAllStudents" class="px-6 py-3 rounded-xl text-sm font-bold bg-white border">Cancel</a>
          </div>

        </form>
      </div>
    </main>
</div>

<script>
function toggleSidebar(){
    const s=document.getElementById('sidebar'), b=document.getElementById('sidebarBackdrop');
    if(s && b){
        if(s.classList.contains('-translate-x-full')){s.classList.remove('-translate-x-full');b.classList.remove('hidden');}
        else{s.classList.add('-translate-x-full');b.classList.add('hidden');}
    }
}
</script>
</body>
</html>