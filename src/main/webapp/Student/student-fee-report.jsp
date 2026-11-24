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
    <title>Fee Report | StudentMS</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>body{font-family:'Inter',sans-serif}</style>
</head>
<body class="bg-[#f6f7fb] text-slate-900">
<div class="flex min-h-screen">
    <jsp:include page="student-sidebar.jsp" />
    <main class="flex-1 min-w-0">
      <!-- SAME NAVBAR -->
      <div class="sticky top-0 z-10 bg-white/90 backdrop-blur border-b px-4 py-3 flex items-center justify-between">
        <div class="flex items-center gap-3">
          <button onclick="toggleSidebar()" class="lg:hidden w-9 h-9 grid place-items-center rounded-xl bg-slate-900 text-white"><i class="fa-solid fa-bars"></i></button>
          <h2 class="font-bold text-[16px]">Fee Report</h2>
        </div>
        <a href="student-dashboard.jsp" class="text-xs bg-slate-900 text-white px-3 py-2 rounded-full">Back to Dashboard</a>
      </div>

      <div class="p-4 lg:p-6 max-w-5xl mx-auto">

        <!-- TOP 3 CARDS -->
        <div class="grid grid-cols-1 sm:grid-cols-3 gap-3">
          <div class="bg-white rounded-2xl border p-4 flex items-center gap-3">
            <div class="w-11 h-11 rounded-xl bg-slate-900 text-white grid place-items-center"><i class="fa-solid fa-indian-rupee-sign"></i></div>
            <div><p class="text-[11px] text-slate-400 font-bold">TOTAL FEE</p><p class="font-extrabold text-lg leading-none">₹${courseTotalFee}</p><p class="text-[11px] text-slate-500 mt-1">${student.course_code} - Sem ${student.semester}</p></div>
          </div>
          <div class="bg-white rounded-2xl border p-4 flex items-center gap-3">
            <div class="w-11 h-11 rounded-xl bg-emerald-50 text-emerald-600 grid place-items-center"><i class="fa-solid fa-circle-check"></i></div>
            <div><p class="text-[11px] text-slate-400 font-bold">PAID FEE</p><p class="font-extrabold text-lg leading-none text-emerald-600">₹${paidFee}</p><p class="text-[11px] text-slate-500 mt-1">${totalInstallments} Installments</p></div>
          </div>
          <div class="bg-white rounded-2xl border p-4 flex items-center gap-3">
            <div class="w-11 h-11 rounded-xl ${dueFee > 0 ? 'bg-red-50 text-red-600' : 'bg-emerald-50 text-emerald-600'} grid place-items-center"><i class="fa-solid fa-triangle-exclamation"></i></div>
            <div><p class="text-[11px] text-slate-400 font-bold">DUE FEE</p><p class="font-extrabold text-lg leading-none ${dueFee > 0 ? 'text-red-600' : 'text-emerald-600'}">₹${dueFee}</p><p class="text-[11px] text-slate-500 mt-1">${dueFee > 0 ? 'Pending - Pay Soon' : 'All Clear'}</p></div>
          </div>
        </div>

        <!-- FEE DETAIL + PROGRESS -->
        <div class="bg-white rounded-[24px] border shadow-sm p-5 mt-4">
            <div class="flex justify-between items-center">
                <h3 class="font-bold text-[14px]">Fee Details</h3>
                <span class="text-[11px] font-bold px-3 py-1 rounded-full ${dueFee > 0 ? 'bg-red-100 text-red-600' : 'bg-emerald-100 text-emerald-600'}">${dueFee > 0 ? 'DUE PENDING' : 'PAID'}</span>
            </div>
            <div class="grid grid-cols-2 sm:grid-cols-4 gap-3 mt-4">
                <div class="bg-[#f6f7fb] rounded-2xl p-3"><p class="text-[10px] text-slate-400 font-bold">COURSE FEE</p><p class="font-bold">₹${courseTotalFee}</p></div>
                <div class="bg-[#f6f7fb] rounded-2xl p-3"><p class="text-[10px] text-slate-400 font-bold">PAID</p><p class="font-bold text-emerald-600">₹${paidFee}</p></div>
                <div class="bg-[#f6f7fb] rounded-2xl p-3"><p class="text-[10px] text-slate-400 font-bold">DUE</p><p class="font-bold text-red-600">₹${dueFee}</p></div>
                <div class="bg-[#f6f7fb] rounded-2xl p-3"><p class="text-[10px] text-slate-400 font-bold">LAST PAYMENT</p><p class="font-bold text-[13px]">${lastPaymentDate} • ${lastMode}</p></div>
            </div>
            <div class="flex justify-between text-[11px] font-bold mt-4"><span>Paid ${percent}%</span><span>${percent}% Completed</span></div>
            <div class="w-full bg-slate-200 rounded-full h-2.5 mt-1.5">
                <div class="h-2.5 rounded-full ${dueFee > 0 ? 'bg-gradient-to-r from-indigo-600 to-emerald-500' : 'bg-emerald-500'}" style="width:${percent}%"></div>
            </div>
            <p class="text-xs text-slate-500 mt-2"><i class="fa-solid fa-user mr-1"></i>${student.full_name} • ${student.roll_number} • ${student.course_code}</p>
        </div>

        <!-- MODE WISE + MONTH WISE REPORT -->
        <div class="grid grid-cols-1 sm:grid-cols-2 gap-3 mt-4">
            <div class="bg-white rounded-[24px] border p-5">
                <h3 class="font-bold text-[14px] mb-3"><i class="fa-solid fa-wallet mr-1 text-indigo-600"></i>Payment Mode Wise Report</h3>
                <c:if test="${empty modeWise}"><p class="text-xs text-slate-400">No payment yet.</p></c:if>
                <c:forEach var="m" items="${modeWise}">
                    <div class="flex justify-between items-center py-2 border-t text-sm"><span class="font-semibold">${m.key}</span><span class="font-bold text-emerald-600">₹${m.value}</span></div>
                </c:forEach>
            </div>
            <div class="bg-white rounded-[24px] border p-5">
                <h3 class="font-bold text-[14px] mb-3"><i class="fa-solid fa-calendar-days mr-1 text-indigo-600"></i>Month Wise Collection</h3>
                <c:if test="${empty monthWise}"><p class="text-xs text-slate-400">No payment yet.</p></c:if>
                <c:forEach var="mm" items="${monthWise}">
                    <div class="flex justify-between items-center py-2 border-t text-sm"><span class="font-semibold">${mm.key}</span><span class="font-bold">₹${mm.value}</span></div>
                </c:forEach>
            </div>
        </div>

        <!-- INSTALLMENT HISTORY -->
        <div class="bg-white rounded-[24px] border shadow-sm p-5 mt-4">
            <div class="flex justify-between items-center mb-4">
                <h3 class="font-bold text-[14px]">Fee Installment History</h3>
                <span class="text-[11px] bg-slate-100 px-3 py-1 rounded-full font-bold">Total: ${totalInstallments} Payments</span>
            </div>
            <div class="overflow-auto">
                <table class="w-full text-sm">
                    <thead class="text-[10px] tracking-widest text-slate-400 text-left"><tr><th class="py-2">#</th><th>DATE</th><th>PAID</th><th>DUE AFTER</th><th>MODE</th><th>STATUS</th></tr></thead>
                    <tbody class="font-semibold text-[12px]">
                        <c:forEach var="f" items="${feeHistory}" varStatus="st">
                        <tr class="border-t"><td class="py-2.5">${st.count}</td><td>${f.paymentDate}</td><td class="text-emerald-600">₹${f.paidFee}</td><td class="text-red-600">₹${f.dueFee}</td><td><span class="bg-slate-100 px-2 py-1 rounded-full text-[10px]">${f.paymentMode}</span></td><td><span class="bg-emerald-50 text-emerald-600 px-2 py-1 rounded-full text-[10px]">PAID</span></td></tr>
                        </c:forEach>
                        <c:if test="${empty feeHistory}"><tr><td colspan="6" class="py-6 text-center text-slate-400 text-[11px]">No fee history yet.</td></tr></c:if>
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