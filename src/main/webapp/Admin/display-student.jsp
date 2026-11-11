<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Students | StudentMS</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        .no-scrollbar::-webkit-scrollbar { display: none; }
        .no-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }
        table { border-collapse: collapse; }
    </style>
</head>
<body class="bg-[#f6f7fb] text-slate-900">

<!-- ===== DELETE POPUP ===== -->
<% if(request.getAttribute("deleted") != null) { %>
<script>
Swal.fire({ title: "Deleted!", text: "Student deleted successfully", icon: "success", timer: 2000, showConfirmButton: false });
</script>
<% } %>

<div class="flex min-h-screen">
    <jsp:include page="sidebar.jsp"></jsp:include>
    <div id="sidebarBackdrop" onclick="toggleSidebar()" class="fixed inset-0 bg-black/40 z-40 hidden md:hidden"></div>
    <main class="flex-1 min-w-0">
     <header class="sticky top-0 z-30 bg-white/80 backdrop-blur-xl border-b border-slate-200 px-4 md:px-8 py-4 flex items-center justify-between gap-4">
            <div class="flex items-center gap-3">
                <button onclick="toggleSidebar()" class="md:hidden w-10 h-10 bg-slate-900 text-white rounded-xl"><i class="fa-solid fa-bars"></i></button>
                <div>
                    <h2 class="font-bold text-[16px] md:text-xl leading-none">Students</h2>
                    <p class="hidden md:block text-xs text-slate-500 mt-1">Welcome back, manage your students</p>
                </div>
            </div>
            <div class="flex items-center gap-2">
                <a href="${pageContext.request.contextPath}/LoadAddServlet" class="bg-zinc-900 text-white px-4 md:px-5 py-2.5 rounded-full md:rounded-xl text-[13px] font-semibold shadow-lg">
                    <i class="fa-solid fa-plus mr-1"></i> Add
                </a>
            </div>
        </header>
        
        <div class="p-4 md:p-8 space-y-6">
            <div class="bg-white rounded-[24px] border border-slate-200 shadow-sm overflow-hidden">
                <div class="p-4 md:p-5 flex flex-col md:flex-row md:items-center justify-between gap-3 border-b border-slate-200">
                    <h3 class="font-bold text-[14px] md:text-[15px]">All Students (${fn:length(studentList)})</h3>
                    <div class="w-full md:w-72 relative">
                        <i class="fa-solid fa-magnifying-glass absolute left-3.5 top-1/2 -translate-y-1/2 text-slate-400 text-xs"></i>
                        <input id="searchInput" onkeyup="filterStudents()" placeholder="Search name, roll, email..." class="w-full pl-9 pr-3 py-2.5 bg-slate-50 border border-slate-200 rounded-full text-[13px] focus:outline-none focus:border-zinc-900">
                    </div>
                </div>
                <div class="hidden md:block overflow-hidden">
                    <table class="w-full text-left table-fixed">
                        <thead class="bg-slate-50 text-[11px] text-slate-500 uppercase tracking-wider font-bold border-b border-slate-200">
                            <tr><th class="px-5 py-3.5 w-[22%]">Student</th><th class="px-3 py-3.5 w-[10%]">Roll No</th><th class="px-3 py-3.5 w-[18%]">Contact</th><th class="px-3 py-3.5 w-[8%]">Semester</th><th class="px-3 py-3.5 w-[14%]">Course</th><th class="px-3 py-3.5 w-[6%]">Year</th><th class="px-3 py-3.5 w-[9%]">Status</th><th class="px-5 py-3.5 w-[13%]">Action</th></tr>
                        </thead>
                        <tbody id="studentTableDesktop" class="divide-y divide-slate-100 text-[13px]">
                            <c:forEach var="s" items="${studentList}">
                                <tr class="hover:bg-slate-50/50"><td class="px-5 py-4"><div class="flex items-center gap-3 overflow-hidden"><img src="https://i.pravatar.cc/100?u=${s.id}" class="w-9 h-9 rounded-full shrink-0 border border-slate-200"><div class="overflow-hidden leading-tight"><p class="font-semibold truncate text-[13px]">${s.full_name}</p><p class="text-[11px] text-slate-500">ID: ${s.id}</p></div></div></td><td class="px-3 py-4 font-semibold text-slate-700 truncate text-[13px]">${s.roll_number}</td><td class="px-3 py-4 overflow-hidden"><div class="leading-tight overflow-hidden"><p class="truncate font-medium text-[12px]">${s.email}</p><p class="text-[11px] text-slate-500 mt-0.5">${s.phone}</p></div></td><td class="px-3 py-4 whitespace-nowrap"><span class="bg-blue-50 text-blue-700 border border-blue-100 px-2.5 py-1 rounded-full text-[11px] font-bold">Sem ${s.semester}</span></td><td class="px-3 py-4 whitespace-nowrap"><span class="bg-slate-100 border border-slate-200 px-2.5 py-1 rounded-full text-[11px] font-bold whitespace-nowrap inline-block">${s.course_code}</span></td><td class="px-3 py-4"><span class="bg-slate-100 border border-slate-200 px-2.5 py-1 rounded-full text-[11px] font-bold">${s.admissionYear}</span></td><td class="px-3 py-4 whitespace-nowrap"><c:choose><c:when test="${s.status == 'ACTIVE'}"><span class="inline-flex items-center gap-1.5 bg-emerald-50 text-emerald-600 border border-emerald-100 px-2.5 py-1 rounded-full text-[11px] font-bold"><span class="w-1.5 h-1.5 bg-emerald-500 rounded-full animate-pulse"></span> ACTIVE</span></c:when><c:when test="${s.status == 'PASSOUT'}"><span class="inline-flex items-center gap-1.5 bg-blue-50 text-blue-700 border border-blue-100 px-2.5 py-1 rounded-full text-[11px] font-bold">PASSOUT</span></c:when><c:when test="${s.status == 'DROPOUT'}"><span class="inline-flex items-center gap-1.5 bg-red-50 text-red-600 border border-red-100 px-2.5 py-1 rounded-full text-[11px] font-bold">DROPOUT</span></c:when><c:otherwise><c:if test="${s.active == true}"><span class="inline-flex items-center gap-1.5 bg-emerald-50 text-emerald-600 border border-emerald-100 px-2.5 py-1 rounded-full text-[11px] font-bold"><span class="w-1.5 h-1.5 bg-emerald-500 rounded-full animate-pulse"></span> ACTIVE</span></c:if><c:if test="${s.active == false}"><span class="inline-flex items-center gap-1.5 bg-slate-100 text-slate-500 border border-slate-200 px-2.5 py-1 rounded-full text-[11px] font-bold">INACTIVE</span></c:if></c:otherwise></c:choose></td><td class="px-5 py-4"><div class="flex gap-1.5"><a href="${pageContext.request.contextPath}/LoadStudenProfile?id=${s.id}" class="w-8 h-8 bg-zinc-50 text-zinc-700 rounded-lg flex items-center justify-center hover:bg-zinc-100 border border-slate-200"><i class="fa-regular fa-eye text-[12px]"></i></a><a href="#" onclick="openModal(${s.id})" class="w-8 h-8 bg-red-50 text-red-600 rounded-lg flex items-center justify-center hover:bg-red-100 border border-red-100"><i class="fa-regular fa-trash-can text-[12px]"></i></a></div></td></tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="md:hidden p-3 space-y-3" id="studentCards">
                    <c:forEach var="s" items="${studentList}">
                    <div class="student-card bg-white border border-slate-200 rounded-[16px] p-4">
                        <div class="flex justify-between items-start"><div class="flex items-center gap-3"><img src="https://i.pravatar.cc/100?u=${s.id}" class="w-10 h-10 rounded-full border border-slate-200"><div><p class="font-bold text-[14px] leading-tight">${s.full_name}</p><p class="text-[11px] text-slate-500">${s.roll_number} • ${s.course_code}</p></div></div><c:choose><c:when test="${s.status == 'ACTIVE'}"><span class="inline-flex items-center gap-1.5 bg-emerald-50 text-emerald-600 border border-emerald-100 px-2.5 py-1 rounded-full text-[10px] font-bold"><span class="w-1.5 h-1.5 bg-emerald-500 rounded-full animate-pulse"></span> ACTIVE</span></c:when><c:when test="${s.status == 'PASSOUT'}"><span class="inline-flex items-center gap-1.5 bg-blue-50 text-blue-700 border border-blue-100 px-2.5 py-1 rounded-full text-[10px] font-bold">PASSOUT</span></c:when><c:when test="${s.status == 'DROPOUT'}"><span class="inline-flex items-center gap-1.5 bg-red-50 text-red-600 border border-red-100 px-2.5 py-1 rounded-full text-[10px] font-bold">DROPOUT</span></c:when><c:otherwise><c:if test="${s.active == true}"><span class="inline-flex items-center gap-1.5 bg-emerald-50 text-emerald-600 border border-emerald-100 px-2.5 py-1 rounded-full text-[10px] font-bold"><span class="w-1.5 h-1.5 bg-emerald-500 rounded-full animate-pulse"></span> ACTIVE</span></c:if><c:if test="${s.active == false}"><span class="inline-flex items-center gap-1.5 bg-slate-100 text-slate-500 border border-slate-200 px-2.5 py-1 rounded-full text-[10px] font-bold">INACTIVE</span></c:if></c:otherwise></c:choose></div>
                        <div class="grid grid-cols-2 gap-2 mt-3 text-[11px]"><div class="bg-[#f6f7fb] rounded-xl p-2.5 border border-slate-100"><p class="text-[9px] text-slate-400 font-bold tracking-widest">EMAIL</p><p class="font-semibold truncate">${s.email}</p></div><div class="bg-[#f6f7fb] rounded-xl p-2.5 border border-slate-100"><p class="text-[9px] text-slate-400 font-bold tracking-widest">PHONE</p><p class="font-semibold">${s.phone}</p></div></div>
                        <div class="flex gap-2 mt-3"><a href="${pageContext.request.contextPath}/LoadStudenProfile?id=${s.id}" class="flex-1 bg-zinc-900 text-white text-center py-2.5 rounded-xl text-[12px] font-bold">View</a><a href="#" onclick="openModal(${s.id})" class="w-11 h-11 bg-red-50 border border-red-100 flex items-center justify-center rounded-xl text-red-500 hover:bg-red-100"><i class="fa-regular fa-trash-can text-xs"></i></a></div>
                    </div>
                    </c:forEach>
                </div>
                <c:if test="${empty studentList}"><div class="py-12 text-center text-slate-400 text-[13px]">Sorry Student Details Are not Available...</div></c:if>
            </div>
        </div>
    </main>
</div>

<form id="delForm" action="${pageContext.request.contextPath}/DeleteStudent" method="POST" class="hidden"><input type="hidden" name="id" id="deleteId"></form>
<div id="deleteModal" class="fixed inset-0 bg-black/50 hidden items-center justify-center z-50 p-4">
  <div class="bg-white rounded-[20px] p-6 w-full max-w-sm shadow-2xl border border-slate-200"><div class="w-12 h-12 bg-red-100 text-red-500 rounded-full flex items-center justify-center mx-auto mb-4 border border-red-200"><i class="fa-regular fa-trash-can"></i></div><h3 class="text-center font-bold text-[16px]">Do you want to delete this Student ?</h3><p class="text-center text-[12px] text-slate-500 mt-1">deleted student can't recover again...</p><div class="flex gap-3 mt-6"><button onclick="closeModal()" class="flex-1 py-2.5 rounded-full bg-slate-100 font-bold text-[13px] border border-slate-200">Cancel</button><button onclick="confirmDelete()" class="flex-1 py-2.5 rounded-full bg-red-500 text-white font-bold text-[13px]">Delete</button></div></div>
</div>

<script>
let modal = document.getElementById('deleteModal');
function openModal(id){ document.getElementById('deleteId').value = id; modal.classList.remove('hidden'); modal.classList.add('flex'); }
function closeModal(){ modal.classList.add('hidden'); modal.classList.remove('flex'); }
function confirmDelete(){ document.getElementById('delForm').submit(); }
function toggleSidebar(){ const s=document.querySelector('aside'), b=document.getElementById('sidebarBackdrop'); if(!s) return; if(s.classList.contains('-translate-x-full')){s.classList.remove('-translate-x-full');b.classList.remove('hidden');} else{s.classList.add('-translate-x-full');b.classList.add('hidden');} }
function filterStudents(){ let q=document.getElementById('searchInput').value.toLowerCase(); document.querySelectorAll('#studentTableDesktop tr').forEach(el=>{ el.style.display = el.innerText.toLowerCase().includes(q) ? '' : 'none'; }); document.querySelectorAll('.student-card').forEach(el=>{ el.style.display = el.innerText.toLowerCase().includes(q) ? '' : 'none'; }); }
</script>
</body>
</html>