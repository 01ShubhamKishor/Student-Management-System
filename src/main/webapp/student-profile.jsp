<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    if(session.getAttribute("admin") == null && session.getAttribute("student") == null){
        response.sendRedirect(request.getContextPath()+ "/login.jsp");
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

<!-- ========== ADD / UPDATE POPUP START ========== -->

<!-- FOR FORWARD (request) -->
<% if(request.getAttribute("added") != null) { %>
<script>
Swal.fire({ title: "Added!", text: "Student added successfully", icon: "success", timer: 2000, showConfirmButton: false });
</script>
<% } %>
<% if(request.getAttribute("updated") != null) { %>
<script>
Swal.fire({ title: "Updated!", text: "Student profile updated successfully", icon: "success", timer: 2000, showConfirmButton: false });
</script>
<% } %>

<!-- FOR REDIRECT (session) -->
<% if(session.getAttribute("added") != null) { %>
<script>
Swal.fire({ title: "Added!", text: "Student added successfully", icon: "success", timer: 2000, showConfirmButton: false });
</script>
<% session.removeAttribute("added"); %>
<% } %>
<% if(session.getAttribute("updated") != null) { %>
<script>
Swal.fire({ title: "Updated!", text: "Student profile updated successfully", icon: "success", timer: 2000, showConfirmButton: false });
</script>
<% session.removeAttribute("updated"); %>
<% } %>

<!-- ========== ADD / UPDATE POPUP END ========== -->

<div class="flex min-h-screen">
    <jsp:include page="/Admin/sidebar.jsp" />
    <main class="flex-1 min-w-0">
      <div class="sticky top-0 z-10 bg-white/90 backdrop-blur border-b px-4 py-3 flex items-center justify-between">
        <div class="flex items-center gap-3">
          <button onclick="toggleSidebar()" class="lg:hidden w-9 h-9 grid place-items-center rounded-xl bg-slate-900 text-white">
            <i class="fa-solid fa-bars"></i>
          </button>
          <h2 class="font-bold text-[16px]">Student Profile</h2>
        </div>
        <a href="${pageContext.request.contextPath}/GetAllStudents" class="text-xs bg-slate-900 text-white px-3 py-2 rounded-full">Back to List</a>
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
                <a href="${pageContext.request.contextPath}/LoadEditStudent?id=${student.id}" class="inline-flex justify-center items-center gap-2 bg-slate-900 text-white px-5 py-2.5 rounded-xl text-sm">
                  <i class="fa-solid fa-pen-to-square"></i> Edit
                </a>
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

              <div class="bg-white border-2 ${dueFee > 0 ? 'border-red-200 bg-red-50/50' : 'border-emerald-200 bg-emerald-50/50'} rounded-2xl p-4 sm:col-span-2">
                <div class="flex justify-between items-center">
                    <p class="text-[11px] tracking-widest ${dueFee > 0 ? 'text-red-400' : 'text-emerald-500'} font-bold">FEE DETAILS</p>
                    <span class="text-[11px] font-bold px-3 py-1 rounded-full ${dueFee > 0 ? 'bg-red-100 text-red-600' : 'bg-emerald-100 text-emerald-600'}">
                        ${dueFee > 0 ? 'DUE PENDING' : 'PAID'}
                    </span>
                </div>
                <div class="grid grid-cols-3 gap-2 mt-3">
                    <div><p class="text-[10px] text-slate-400 font-bold">COURSE FEE</p><p class="font-bold">₹${courseTotalFee}</p></div>
                    <div><p class="text-[10px] text-slate-400 font-bold">PAID</p><p class="font-bold text-emerald-600">₹${paidFee}</p></div>
                    <div><p class="text-[10px] text-slate-400 font-bold">DUE FEE</p><p class="font-extrabold text-lg ${dueFee > 0 ? 'text-red-600' : 'text-emerald-600'}">₹${dueFee}</p></div>
                </div>
                <div class="w-full bg-slate-200 rounded-full h-2 mt-3">
                    <div class="h-2 rounded-full ${dueFee > 0 ? 'bg-red-500' : 'bg-emerald-500'}" style="width: ${courseTotalFee > 0 ? (paidFee * 100 / courseTotalFee) : 0}%"></div>
                </div>
              </div>

              <div class="bg-[#f6f7fb] rounded-2xl p-4 sm:col-span-2">
                <p class="text-[11px] tracking-widest text-slate-400 font-bold">ADDRESS</p>
                <p class="font-semibold mt-1">${student.address}</p>
              </div>
            </div>
          </div>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-3 gap-3 mt-4">
          <div class="bg-white rounded-2xl border p-4 flex items-center gap-3">
            <div class="w-10 h-10 rounded-xl bg-indigo-50 grid place-items-center text-indigo-600"><i class="fa-solid fa-book"></i></div>
            <div><p class="font-bold leading-none">${student.course_code}</p><p class="text-xs text-slate-500">Fee: ₹${courseTotalFee}</p></div>
          </div>
          <div class="bg-white rounded-2xl border p-4 flex items-center gap-3">
            <div class="w-10 h-10 rounded-xl bg-emerald-50 grid place-items-center text-emerald-600"><i class="fa-solid fa-wallet"></i></div>
            <div><p class="font-bold leading-none">Paid: ₹${paidFee}</p></div>
          </div>
          <div class="bg-white rounded-2xl border p-4 flex items-center gap-3">
            <div class="w-10 h-10 rounded-xl ${dueFee > 0 ? 'bg-red-50 text-red-600' : 'bg-emerald-50 text-emerald-600'} grid place-items-center"><i class="fa-solid fa-indian-rupee-sign"></i></div>
            <div><p class="font-bold leading-none ${dueFee > 0 ? 'text-red-600' : 'text-emerald-600'}">Due: ₹${dueFee}</p><p class="text-xs text-slate-500">${dueFee > 0 ? 'Pending' : 'Cleared'}</p></div>
          </div>
        </div>

        <div class="bg-white rounded-[24px] border shadow-sm p-5 mt-4">
            <div class="flex justify-between items-center mb-4">
                <h3 class="font-bold text-[14px]">Fee Installment History</h3>
                <a href="${pageContext.request.contextPath}/Reports" class="text-[11px] bg-emerald-600 text-white px-3 py-1.5 rounded-full font-bold">+ Add Fee</a>
            </div>
            <div class="overflow-auto">
                <table class="w-full text-sm">
                    <thead class="text-[10px] tracking-widest text-slate-400 text-left"><tr><th class="py-2">DATE</th><th>PAID</th><th>DUE</th><th>MODE</th></tr></thead>
                    <tbody class="font-semibold text-[12px]">
                        <c:forEach var="f" items="${feeHistory}">
                        <tr class="border-t"><td class="py-2.5">${f.paymentDate}</td><td class="text-emerald-600">₹${f.paidFee}</td><td class="text-red-600">₹${f.dueFee}</td><td><span class="bg-slate-100 px-2 py-1 rounded-full text-[10px]">${f.paymentMode}</span></td></tr>
                        </c:forEach>
                        <c:if test="${empty feeHistory}"><tr><td colspan="4" class="py-6 text-center text-slate-400 text-[11px]">No fee history yet.</td></tr></c:if>
                    </tbody>
                </table>
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