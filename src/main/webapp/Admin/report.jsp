<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fee Reports | StudentMS</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body class="bg-[#f6f7fb] text-slate-900">

<div class="flex min-h-screen">
    <jsp:include page="sidebar.jsp"></jsp:include>
    <div id="sidebarBackdrop" onclick="toggleSidebar()" class="fixed inset-0 bg-black/40 z-40 hidden md:hidden"></div>

    <main class="flex-1 min-w-0">
    <header class="sticky top-0 z-30 bg-white/80 backdrop-blur-xl border-b border-slate-200 px-4 md:px-8 py-4 flex items-center justify-between">
            <div class="flex items-center gap-3">
                <button onclick="toggleSidebar()" class="md:hidden w-10 h-10 bg-slate-900 text-white rounded-xl"><i class="fa-solid fa-bars"></i></button>
                <div>
                    <h2 class="font-bold text-xl leading-none">Fee Reports</h2>
                    <p class="text-xs text-slate-500 mt-1">Manage fee & dues</p>
                </div>
            </div>
            <a href="Admin/admin-pannel.jsp" class="text-xs bg-slate-100 px-3 py-2 rounded-full font-bold">← Dashboard</a>
    </header>
    
    <!-- SUCCESS POPUP -->
<c:if test="${param.msg == 'success'}">
<div id="toast" class="fixed top-5 left-1/2 -translate-x-1/2 z-[9999] bg-white border border-emerald-200 shadow-2xl rounded-2xl px-5 py-4 flex items-center gap-3">
    <div class="w-9 h-9 bg-emerald-600 text-white rounded-full flex items-center justify-center"><i class="fa-solid fa-check"></i></div>
    <p class="font-bold text-sm">Fee Submitted Successfully!</p>
</div>
<script>setTimeout(()=>document.getElementById('toast')?.remove(), 3000);</script>
</c:if>
<!-- End pop up for Success payment -->

    <div class="p-4 md:p-8">
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
            
            <!-- Highest Due - Light BG Design -->
            <div class="order-2 lg:order-2">
                <div class="bg-white rounded-[24px] border border-slate-200 p-5 shadow-sm">
                    <h3 class="font-bold flex items-center gap-2 text-[14px]"><i class="fa-solid fa-triangle-exclamation text-red-500"></i> Highest Due (Top 10)</h3>
                    <p class="text-[10px] text-slate-400 mt-1">Highest due amount first</p>
                    <div class="mt-4 space-y-3">
                        <c:forEach var="s" items="${topDueStudents}">
                        <div class="flex justify-between items-center bg-[#f6f7fb] border border-slate-100 rounded-2xl p-3">
                            <div class="flex-1 min-w-0 pr-2">
                                <p class="font-bold text-[13px] truncate">${s.full_name}</p>
                                <p class="text-[11px] text-slate-500 truncate">${s.course_code} • Paid: &#8377;${s.total_fee}</p>
                            </div>
                            <div class="flex items-center gap-2 shrink-0">
                                <p class="text-[12px] font-extrabold text-red-600 mr-1">&#8377;${s.dueAmount}</p>
                                <a href="${pageContext.request.contextPath}/LoadStudenProfile?id=${s.id}" 
                                   class="w-8 h-8 bg-white text-slate-600 border border-slate-200 rounded-full flex items-center justify-center text-[12px] hover:bg-slate-900 hover:text-white hover:border-slate-900 transition-all shadow-sm"
                                   title="View Profile">
                                    <i class="fa-solid fa-user"></i>
                                </a>
                                <button onclick="openAddFee(${s.id})" class="text-[11px] bg-emerald-600 hover:bg-emerald-700 text-white px-3.5 py-2 rounded-full font-bold shadow-sm transition">PAY</button>
                            </div>
                        </div>
                        </c:forEach>
                        <c:if test="${empty topDueStudents}">
                            <p class="text-center text-[11px] text-slate-400 py-10">No Due Found</p>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div class="order-1 lg:order-1 lg:col-span-2">
                <div class="bg-white rounded-[24px] border border-slate-200 p-5 shadow-sm">
                    
                    <div class="flex justify-center mb-6">
                        <div class="bg-[#f6f7fb] rounded-full border border-slate-200 p-1.5 flex gap-1.5 w-fit shadow-inner">
                            <button id="btn-addFeeView" onclick="showView('addFeeView')" class="toggle-btn bg-slate-900 text-white px-5 py-2 rounded-full text-[12px] font-bold transition">
                                <i class="fa-solid fa-plus mr-1"></i> Add Fee
                            </button>
                            <button id="btn-dueView" onclick="showView('dueView')" class="toggle-btn bg-white text-slate-600 px-5 py-2 rounded-full text-[12px] font-bold transition">
                                <i class="fa-solid fa-users mr-1"></i> Fee Due Students
                            </button>
                            <button id="btn-courseView" onclick="showView('courseView')" class="toggle-btn bg-white text-slate-600 px-5 py-2 rounded-full text-[12px] font-bold transition">
                                <i class="fa-solid fa-chart-pie mr-1"></i> Course Wise Due
                            </button>
                        </div>
                    </div>

                    <div id="courseView" class="view-panel hidden">
                        <div class="flex justify-between items-center mb-4">
                            <h3 class="font-bold">Course Wise Fee Report</h3>
                            <span class="text-[11px] bg-slate-900 text-white px-3 py-1 rounded-full">${fn:length(courseReport)} Courses</span>
                        </div>
                        <div class="overflow-x-auto -mx-5 px-5">
                            <table class="w-full text-sm min-w-[500px]">
                                <thead class="text-[11px] tracking-widest text-slate-400 text-left">
                                    <tr><th class="py-2">COURSE</th><th>STUDENTS</th><th>COURSE FEE</th><th>COLLECTED</th><th>DUE</th></tr>
                                </thead>
                                <tbody class="font-semibold">
                                    <c:forEach var="cr" items="${courseReport}">
                                    <tr class="border-t hover:bg-slate-50">
                                        <td class="py-3">${cr.courseName} (${cr.courseCode})</td>
                                        <td>${cr.totalStudents}</td>
                                        <td>&#8377;${cr.courseFee}</td>
                                        <td class="text-emerald-600">&#8377;${cr.collected}</td>
                                        <td class="text-red-600">&#8377;${cr.due}</td>
                                    </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div id="dueView" class="view-panel hidden">
                        <div class="flex justify-between items-center mb-4">
                            <h3 class="font-bold">All Due Students</h3>
                            <span class="text-[11px] bg-red-100 text-red-600 px-3 py-1 rounded-full font-bold">${fn:length(dueStudents)} Due</span>
                        </div>
                        <div class="overflow-x-auto max-h-[600px] -mx-5 px-5">
                            <table class="w-full text-sm min-w-[580px]">
                                <thead class="text-[11px] tracking-widest text-slate-400 text-left sticky top-0 bg-white z-10">
                                    <tr>
                                        <th class="py-2">STUDENT</th>
                                        <th>PAID</th>
                                        <th>DUE</th>
                                        <th class="text-center w-[110px]">ACTION</th>
                                    </tr>
                                </thead>
                                <tbody class="font-semibold">
                                    <c:forEach var="s" items="${dueStudents}">
                                    <tr class="border-t hover:bg-slate-50">
                                        <td class="py-3 pr-2">${s.full_name} #${s.id}</td>
                                        <td class="text-emerald-600 pr-2">&#8377;${s.total_fee}</td>
                                        <td class="text-red-600 pr-2">&#8377;${s.dueAmount}</td>
                                        <td class="py-2">
                                            <div class="flex items-center justify-center gap-2">
                                                <a href="${pageContext.request.contextPath}/LoadStudenProfile?id=${s.id}" 
                                                   class="w-8 h-8 bg-white text-slate-600 border border-slate-200 rounded-full flex items-center justify-center text-[12px] hover:bg-slate-900 hover:text-white hover:border-slate-900 transition-all shadow-sm shrink-0">
                                                   <i class="fa-solid fa-user"></i>
                                                </a>
                                                <button onclick="openAddFee(${s.id})" class="bg-emerald-600 hover:bg-emerald-700 text-white text-[11px] px-4 py-1.5 rounded-full font-bold shrink-0 shadow-sm transition">PAY</button>
                                            </div>
                                        </td>
                                    </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div id="addFeeView" class="view-panel">
                        <jsp:include page="addFeeForm.jsp"></jsp:include>
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
function showView(viewId){
    document.querySelectorAll('.view-panel').forEach(el => el.classList.add('hidden'));
    document.getElementById(viewId).classList.remove('hidden');
    document.querySelectorAll('.toggle-btn').forEach(btn => {
        btn.classList.remove('bg-slate-900','text-white');
        btn.classList.add('bg-white','text-slate-600');
    });
    const activeBtn = document.getElementById('btn-' + viewId);
    if(activeBtn){
        activeBtn.classList.remove('bg-white','text-slate-600');
        activeBtn.classList.add('bg-slate-900','text-white');
    }
}
</script>
</body>
</html>