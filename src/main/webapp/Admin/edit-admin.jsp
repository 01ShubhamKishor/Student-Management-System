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
    <title>Admin Home | StudentMS</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>body{font-family:'Inter',sans-serif}</style>
</head>
<body class="bg-[#f6f7fb] text-slate-900">

<div class="flex min-h-screen">
     <jsp:include page="sidebar.jsp"></jsp:include>
    <main class="flex-1 min-w-0">
      <div class="sticky top-0 z-10 bg-white/90 backdrop-blur border-b px-4 py-3 flex items-center justify-between">
        <div class="flex items-center gap-3">
          <button onclick="toggleSidebar()" class="lg:hidden w-9 h-9 grid place-items-center rounded-xl bg-slate-900 text-white">
            <i class="fa-solid fa-bars"></i>
          </button>
          <h2 class="font-bold text-[16px]">Edit Admin Profile</h2>
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
                <h3 class="text-xl font-extrabold leading-none">${UAdmin.user_name}</h3>
                <p class="text-sm text-slate-500 mt-1">
                  <i class="fa-solid fa-envelope mr-1"></i> ${UAdmin.email} • ${UAdmin.role} • 
                  <c:choose>
                    <c:when test="${UAdmin.active}"><span class="px-2 py-0.5 rounded-full bg-green-100 text-green-700 text-[11px] font-bold">ACTIVE</span></c:when>
                    <c:otherwise><span class="px-2 py-0.5 rounded-full bg-red-100 text-red-600 text-[11px] font-bold">INACTIVE</span></c:otherwise>
                  </c:choose>
                </p>
              </div>
            </div>

            <form action="${pageContext.request.contextPath}/UpdateAdminProfile?id=${UAdmin.id}" method="post" class="mt-6">
              <input type="hidden" name="id" value="${UAdmin.id}">
              <div class="grid grid-cols-1 sm:grid-cols-2 gap-3">
                
                <div class="bg-[#f6f7fb] rounded-2xl p-4">
                  <p class="text-[11px] tracking-widest text-slate-400 font-bold">USER NAME</p>
                  <input type="text" name="user_name" value="${UAdmin.user_name}" class="w-full mt-1 bg-white border rounded-xl px-3 py-2 font-semibold text-sm outline-none focus:ring-2 focus:ring-slate-900">
                </div>

                <div class="bg-[#f6f7fb] rounded-2xl p-4">
                  <p class="text-[11px] tracking-widest text-slate-400 font-bold">EMAIL</p>
                  <input type="email" name="email" value="${UAdmin.email}" class="w-full mt-1 bg-white border rounded-xl px-3 py-2 font-semibold text-sm outline-none focus:ring-2 focus:ring-slate-900">
                </div>

                <div class="bg-[#f6f7fb] rounded-2xl p-4">
                  <p class="text-[11px] tracking-widest text-slate-400 font-bold">PASSWORD</p>
                  <input type="text" name="password" value="${UAdmin.password}" class="w-full mt-1 bg-white border rounded-xl px-3 py-2 font-semibold text-sm outline-none focus:ring-2 focus:ring-slate-900">
                </div>

                <!-- ROLE LOGIC UPDATED AS PER REQUIREMENT -->
                <div class="bg-[#f6f7fb] rounded-2xl p-4">
                  <p class="text-[11px] tracking-widest text-slate-400 font-bold">ROLE</p>
                  <select name="role" class="w-full mt-1 bg-white border rounded-xl px-3 py-2 font-semibold text-sm outline-none">
                    <c:choose>
                      <c:when test="${sessionScope.role == 'SUPER_ADMIN' || UAdmin.role == 'SUPER_ADMIN'}">
                        <!-- SUPER_ADMIN ke liye 2 option, default SUPER_ADMIN -->
                        <option value="SUPER_ADMIN" selected>SUPER_ADMIN</option>
                        <option value="ADMIN">ADMIN</option>
                      </c:when>
                      <c:otherwise>
                        <!-- ADMIN ke liye sirf ADMIN -->
                        <option value="ADMIN" selected>ADMIN</option>
                      </c:otherwise>
                    </c:choose>
                  </select>
                </div>

                <div class="bg-[#f6f7fb] rounded-2xl p-4">
                  <p class="text-[11px] tracking-widest text-slate-400 font-bold">CONTACT</p>
                  <input type="text" name="contact" value="${UAdmin.contact}" class="w-full mt-1 bg-white border rounded-xl px-3 py-2 font-semibold text-sm outline-none focus:ring-2 focus:ring-slate-900">
                </div>

                <div class="bg-[#f6f7fb] rounded-2xl p-4">
                  <p class="text-[11px] tracking-widest text-slate-400 font-bold">DOB</p>
                  <input type="date" name="dob" value="${UAdmin.dob}" class="w-full mt-1 bg-white border rounded-xl px-3 py-2 font-semibold text-sm outline-none focus:ring-2 focus:ring-slate-900">
                </div>

                <div class="bg-[#f6f7fb] rounded-2xl p-4 sm:col-span-2 border-2 ${UAdmin.active ? 'border-green-200 bg-green-50/50' : 'border-red-200 bg-red-50/50'}">
                  <p class="text-[11px] tracking-widest text-slate-400 font-bold">IS ACTIVE?</p>
                  <div class="flex items-center gap-3 mt-2">
                    <select name="active" class="flex-1 bg-white border rounded-xl px-3 py-2 font-bold text-sm outline-none focus:ring-2 focus:ring-slate-900">
                      <option value="true" ${UAdmin.active ? 'selected' : ''}>YES - ACTIVE</option>
                      <option value="false" ${!UAdmin.active ? 'selected' : ''}>NO - INACTIVE</option>
                    </select>
                    <div class="text-xs font-bold ${UAdmin.active ? 'text-green-600' : 'text-red-600'}">
                      <c:if test="${UAdmin.active}"><i class="fa-solid fa-circle-check mr-1"></i> Currently Active</c:if>
                      <c:if test="${!UAdmin.active}"><i class="fa-solid fa-circle-xmark mr-1"></i> Currently Inactive</c:if>
                    </div>
                  </div>
                </div>

                <div class="bg-[#f6f7fb] rounded-2xl p-4 sm:col-span-2">
                  <p class="text-[11px] tracking-widest text-slate-400 font-bold">ADDRESS</p>
                  <textarea name="address" rows="2" class="w-full mt-1 bg-white border rounded-xl px-3 py-2 font-semibold text-sm outline-none focus:ring-2 focus:ring-slate-900">${UAdmin.address}</textarea>
                </div>

              </div>

              <button type="submit" class="w-full mt-6 bg-slate-900 text-white py-3 rounded-2xl text-sm font-bold">
                <i class="fa-solid fa-floppy-disk mr-2"></i> Update Admin
              </button>
            </form>

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