<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Courses | StudentMS</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        .no-scrollbar::-webkit-scrollbar { display: none; }
        .no-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }
        table { border-collapse: collapse; }
    </style>
</head>
<body class="bg-[#f6f7fb] text-slate-900">

<div class="flex min-h-screen">
    <div id="sidebarBackdrop" onclick="toggleSidebar()" class="fixed inset-0 bg-black/40 z-40 hidden md:hidden"></div>
    <jsp:include page="sidebar.jsp"></jsp:include>

    <main class="flex-1 min-w-0 overflow-hidden">
        <header class="sticky top-0 z-30 bg-white/80 backdrop-blur-xl border-b border-slate-200 px-4 md:px-8 py-4 flex items-center justify-between gap-4">
            <div class="flex items-center gap-3">
                <button onclick="toggleSidebar()" class="md:hidden w-10 h-10 bg-slate-900 text-white rounded-xl"><i class="fa-solid fa-bars"></i></button>
                <div>
                    <h2 class="font-bold text-[16px] md:text-xl leading-none">Courses</h2>
                    <p class="hidden md:block text-xs text-slate-500 mt-1">Welcome back, manage your courses</p>
                </div>
            </div>
            <a href="${pageContext.request.contextPath}/Admin/addcourse.jsp" class="bg-zinc-900 text-white px-4 md:px-5 py-2.5 rounded-full md:rounded-xl text-[13px] font-semibold shadow-lg">
                <i class="fa-solid fa-plus mr-1"></i> Add Course
            </a>
        </header>

        <div class="p-4 md:p-8 max-w-[1280px] mx-auto space-y-5">
            
            <div class="grid grid-cols-3 gap-3">
                <div class="bg-white border border-slate-200 rounded-[16px] md:rounded-[20px] p-4">
                    <p class="text-[11px] font-bold text-slate-400 uppercase tracking-widest">Total</p>
                    <h3 class="text-[20px] font-extrabold mt-1">${totalCourses}</h3>
                    <p class="text-[12px] text-slate-500">Courses</p>
                </div>
                <div class="bg-white border border-slate-200 rounded-[16px] md:rounded-[20px] p-4">
                    <p class="text-[11px] font-bold text-emerald-600 uppercase tracking-widest">Active</p>
                    <h3 class="text-[20px] font-extrabold mt-1 text-emerald-600">${activeCourses}</h3>
                    <p class="text-[12px] text-slate-500">Live Courses</p>
                </div>
                <div class="bg-white border border-slate-200 rounded-[16px] md:rounded-[20px] p-4">
                    <p class="text-[11px] font-bold text-slate-400 uppercase tracking-widest">Inactive</p>
                    <h3 class="text-[20px] font-extrabold mt-1">${totalCourses-activeCourses}</h3>
                    <p class="text-[12px] text-slate-500">Disabled</p>
                </div>
            </div>

            <div class="bg-white border border-slate-200 rounded-[20px] md:rounded-[24px] p-3 md:p-4 flex items-center gap-3 shadow-sm">
                <div class="flex-1 flex items-center gap-2 bg-slate-50 border border-slate-200 rounded-full md:rounded-xl px-3.5 py-2.5">
                    <i class="fa-solid fa-magnifying-glass text-slate-400 text-[13px]"></i>
                    <input id="searchInput" onkeyup="filterCourses()" type="text" placeholder="Search course, code, dept..." class="bg-transparent w-full outline-none text-[13px]">
                </div>
                <select id="deptFilter" onchange="filterCourses()" class="bg-slate-50 border border-slate-200 rounded-full md:rounded-xl px-4 py-2.5 text-[13px] outline-none font-semibold">
                    <option value="">All Dept</option>
                    <option>Computer Science</option>
                    <option>Mechanical</option>
                    <option>Civil</option>
                    <option>Commerce</option>
                </select>
            </div>

            <div class="hidden md:block bg-white rounded-[24px] border border-slate-200 overflow-hidden shadow-sm">
                <table class="w-full table-fixed text-left">
                    <thead class="bg-slate-50 text-[11px] font-bold text-slate-500 uppercase tracking-wider border-b border-slate-200">
                        <tr>
                            <th class="px-5 py-3 w-[18%]">Course</th>
                            <th class="px-4 py-3 w-[20%]">Department</th>
                            <th class="px-4 py-3 w-[9%]">Duration</th>
                            <th class="px-4 py-3 w-[9%]">Total Sem</th>
                            <th class="px-4 py-3 w-[13%]">Fees</th>
                            <th class="px-4 py-3 w-[9%]">Status</th>
                            <th class="px-5 py-3 w-[22%] text-center">Action</th>
                        </tr>
                    </thead>
                    <tbody id="desktopBody">
                        <c:choose>
                            <c:when test="${not empty courses}">
                                <c:forEach var="c" items="${courses}">
                                    <tr class="course-row border-b border-slate-100 hover:bg-slate-50/50 cursor-pointer last:border-0" 
                                        data-name="${fn:toLowerCase(c.course)} ${fn:toLowerCase(c.course_code)} ${fn:toLowerCase(c.department)}"
                                        onclick="window.location='${pageContext.request.contextPath}/CourseProfile?id=${c.id}'">
                                        <td class="px-5 py-4">
                                            <p class="font-bold text-[13px] truncate">${c.course_code}</p>
                                            <p class="text-[11px] text-slate-500 truncate">${c.course}</p>
                                        </td>
                                        <td class="px-4 py-4 text-[12px] truncate">${c.department}</td>
                                        <td class="px-4 py-4 text-[12px]">${c.duration_year} Yrs</td>
                                        <td class="px-4 py-4 text-[12px] font-bold">${c.total_semester} Sem</td>
                                        <td class="px-4 py-4 text-[12px] font-bold">₹${c.fee}.00</td>
                                        <td class="px-4 py-4">
                                            <c:choose>
                                                <c:when test="${c.active}"><span class="inline-flex items-center gap-1.5 bg-emerald-50 text-emerald-600 border border-emerald-100 px-2.5 py-1 rounded-full text-[11px] font-bold"><span class="w-1.5 h-1.5 bg-emerald-500 rounded-full animate-pulse"></span> ACTIVE</span></c:when>
                                                <c:otherwise><span class="inline-flex items-center gap-1.5 bg-slate-100 text-slate-500 border border-slate-200 px-2.5 py-1 rounded-full text-[11px] font-bold">INACTIVE</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="px-5 py-4">
                                            <div class="flex justify-center items-center gap-1.5" onclick="event.stopPropagation()">
                                                <a href="${pageContext.request.contextPath}/LoadEditCourse?id=${c.id}" class="w-8 h-8 bg-amber-50 text-amber-600 rounded-lg flex items-center justify-center hover:bg-amber-100 border border-amber-100"><i class="fa-solid fa-pen text-[11px]"></i></a>
                                                <c:if test="${sessionScope.adminRole == 'SUPER_ADMIN'}">
                                                <form action="${pageContext.request.contextPath}/DeleteCourse" method="post" onsubmit="event.preventDefault(); event.stopPropagation(); openModal(this);">
                                                    <input type="hidden" name="id" value="${c.id}">
                                                    <button class="w-8 h-8 bg-red-50 text-red-600 rounded-lg flex items-center justify-center hover:bg-red-100 border border-red-100"><i class="fa-solid fa-trash text-[11px]"></i></button>
                                                </form>
                                                </c:if>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr><td colspan="7" class="py-10 text-center text-slate-400 text-[13px]">Sorry Courses Details Are not Available...</td></tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

            <div class="md:hidden space-y-3" id="mobileCards">
                <c:choose>
                <c:when test="${not empty courses}">
                    <c:forEach var="c" items="${courses}">
                        <div class="course-card bg-white border border-slate-200 rounded-[16px] p-4" data-name="${fn:toLowerCase(c.course)} ${fn:toLowerCase(c.course_code)} ${fn:toLowerCase(c.department)}">
                            <div class="flex justify-between items-start">
                                <div>
                                    <p class="text-[11px] font-bold bg-zinc-900 text-white px-3 py-1 rounded-full inline-block tracking-wider">${c.course_code}</p>
                                    <h3 class="font-bold text-[14px] mt-2">${c.course}</h3>
                                    <p class="text-[12px] text-slate-500 mt-0.5"><i class="fa-solid fa-building-columns mr-1"></i>${c.department}</p>
                                </div>
                                <div>
                                     <c:choose>
                                  <c:when test="${c.active}"><span class="inline-flex items-center gap-1.5 bg-emerald-50 text-emerald-600 border border-emerald-100 px-2.5 py-1 rounded-full text-[11px] font-bold"><span class="w-1.5 h-1.5 bg-emerald-500 rounded-full animate-pulse"></span> ACTIVE</span></c:when>
                                  <c:otherwise><span class="inline-flex items-center gap-1.5 bg-slate-100 text-slate-500 border border-slate-200 px-2.5 py-1 rounded-full text-[11px] font-bold">INACTIVE</span></c:otherwise>
                                  </c:choose>
                                </div>
                            </div>
                            <div class="grid grid-cols-3 gap-2 mt-4 bg-[#f6f7fb] border border-slate-100 rounded-xl p-3">
                                <div class="text-center"><p class="text-[10px] text-slate-400 font-bold uppercase tracking-widest">Duration</p><p class="text-[13px] font-bold mt-1">${c.duration_year} Yrs</p></div>
                                <div class="text-center border-x border-slate-200"><p class="text-[10px] text-slate-400 font-bold uppercase tracking-widest">Semester</p><p class="text-[13px] font-bold mt-1">${c.total_semester}</p></div>
                                <div class="text-center"><p class="text-[10px] text-slate-400 font-bold uppercase tracking-widest">Fees</p><p class="text-[13px] font-bold mt-1">₹${c.fee}</p></div>
                            </div>
                            <div class="flex gap-2 mt-3">
                                <a href="${pageContext.request.contextPath}/LoadEditCourse?id=${c.id}" class="flex-1 bg-amber-50 text-amber-600 border border-amber-100 text-center py-2.5 rounded-xl text-[12px] font-bold hover:bg-amber-100">Edit</a>
                                <c:if test="${sessionScope.adminRole == 'SUPER_ADMIN'}">
                                <form action="${pageContext.request.contextPath}/DeleteCourse" method="post" class="flex-1" onsubmit="event.preventDefault(); openModal(this);">
                                    <input type="hidden" name="id" value="${c.id}">
                                    <button type="submit" class="w-full bg-red-50 border border-red-100 text-red-600 text-center py-2.5 rounded-xl text-[12px] font-bold hover:bg-red-100">Delete</button>
                                </form>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="bg-white border border-slate-200 rounded-[20px] p-6 text-center text-slate-400 text-[13px]">Sorry Courses Details Are not Available...</div>
                </c:otherwise>
            </c:choose>
            </div>

        </div>
    </main>
</div>

<div id="deleteModal" class="hidden fixed inset-0 bg-black/50 backdrop-blur-sm items-center justify-center z-50 p-4">
  <div class="bg-white rounded-[20px] p-6 w-[90%] max-w-sm shadow-2xl border border-slate-200">
    <div class="w-12 h-12 bg-red-100 text-red-500 rounded-full flex items-center justify-center mx-auto mb-4 border border-red-200"><i class="fa-regular fa-trash-can"></i></div>
    <h3 class="font-bold text-[16px] text-center">Delete Course?</h3>
    <p class="text-[12px] text-slate-500 mt-1 text-center">Ye action undo nahi hoga.</p>
    <div class="flex gap-3 mt-6">
      <button type="button" onclick="closeModal()" class="flex-1 py-2.5 bg-slate-100 border border-slate-200 rounded-full text-[13px] font-bold">Cancel</button>
      <button type="button" onclick="confirmDelete()" class="flex-1 py-2.5 bg-red-500 text-white rounded-full text-[13px] font-bold">Delete</button>
    </div>
  </div>
</div>

<script>
let deleteForm = null;
function openModal(form){ deleteForm = form; document.getElementById('deleteModal').classList.remove('hidden'); document.getElementById('deleteModal').classList.add('flex'); }
function closeModal(){ document.getElementById('deleteModal').classList.add('hidden'); document.getElementById('deleteModal').classList.remove('flex'); deleteForm = null; }
function confirmDelete(){ if(deleteForm) deleteForm.submit(); }
function toggleSidebar(){
    const s=document.querySelector('aside'), b=document.getElementById('sidebarBackdrop');
    if(!s) return;
    s.classList.contains('-translate-x-full') ? (s.classList.remove('-translate-x-full'), b.classList.remove('hidden')) : (s.classList.add('-translate-x-full'), b.classList.add('hidden'));
}
function filterCourses(){
    let q = document.getElementById('searchInput').value.toLowerCase();
    let dept = document.getElementById('deptFilter').value.toLowerCase();
    document.querySelectorAll('.course-card, .course-row').forEach(el=>{
        let name = (el.getAttribute('data-name') || '').toLowerCase();
        let matchSearch = name.includes(q);
        let matchDept = dept === '' || name.includes(dept);
        el.style.display = (matchSearch && matchDept) ? '' : 'none';
    });
}
</script>
</body>
</html>