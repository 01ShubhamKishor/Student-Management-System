<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <title>Admin | StudentMS</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        .no-scrollbar::-webkit-scrollbar { display: none; }
        .no-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }
        table { border-collapse: collapse; }
        @keyframes scaleIn { from { transform: scale(0.95); opacity:0 } to { transform: scale(1); opacity:1 } }
        .hide-scroll::-webkit-scrollbar { display: none; }
        .hide-scroll { -ms-overflow-style: none; scrollbar-width: none; }
    </style>
</head>
<body class="bg-[#f6f7fb] text-slate-900">

<!-- ===== POPUP - REQUEST + SESSION DONO SUPPORT ===== -->
<% if(request.getAttribute("added") != null || session.getAttribute("added") != null) { %>
<script> Swal.fire({ title: "Added!", text: "Admin added successfully", icon: "success", timer: 2000, showConfirmButton: false }); </script>
<% session.removeAttribute("added"); %>
<% } %>
<% if(request.getAttribute("updated") != null || session.getAttribute("updated") != null) { %>
<script> Swal.fire({ title: "Updated!", text: "Admin updated successfully", icon: "success", timer: 2000, showConfirmButton: false }); </script>
<% session.removeAttribute("updated"); %>
<% } %>
<% if(request.getAttribute("deleted") != null || session.getAttribute("deleted") != null) { %>
<script> Swal.fire({ title: "Deleted!", text: "Admin deleted successfully", icon: "success", timer: 2000, showConfirmButton: false }); </script>
<% session.removeAttribute("deleted"); %>
<% } %>

<div class="flex min-h-screen">
    <jsp:include page="sidebar.jsp"></jsp:include>
    <div id="sidebarBackdrop" onclick="toggleSidebar()" class="fixed inset-0 bg-black/40 z-40 hidden md:hidden"></div>
    <main class="flex-1 min-w-0">
        <header class="sticky top-0 z-30 bg-white/80 backdrop-blur-xl border-b border-slate-200 px-4 md:px-8 py-4 flex items-center justify-between gap-4">
            <div class="flex items-center gap-3">
                <button onclick="toggleSidebar()" class="md:hidden w-10 h-10 bg-slate-900 text-white rounded-xl"><i class="fa-solid fa-bars"></i></button>
                <div>
                    <h2 class="font-bold text-[16px] md:text-xl leading-none">Admin Management</h2>
                    <p class="hidden md:block text-xs text-slate-500 mt-1">Logged in as ${sessionScope.adminRole} ${sessionScope.role} - Total: ${fn:length(adminList)}</p>
                </div>
            </div>
            <div>
                <c:if test="${sessionScope.adminRole == 'SUPER_ADMIN' || sessionScope.role == 'SUPER_ADMIN'}">
                <button onclick="openAddModal()" class="bg-zinc-900 text-white px-4 md:px-5 py-2.5 rounded-full md:rounded-xl text-[13px] font-semibold shadow-lg"><i class="fa-solid fa-plus mr-1"></i> Add Admin</button>
                </c:if>
            </div>
        </header>

        <div class="p-4 md:p-8">
            <div class="bg-white rounded-[24px] border border-slate-200 shadow-sm overflow-hidden">
                <div class="p-4 md:p-5 flex flex-col md:flex-row md:items-center justify-between gap-3 border-b">
                    <h3 class="font-bold text-[14px]">All Admins (${fn:length(adminList)})</h3>
                    <div class="w-full md:w-72 relative">
                        <i class="fa-solid fa-magnifying-glass absolute left-3.5 top-1/2 -translate-y-1/2 text-slate-400 text-xs"></i>
                        <input id="searchInput" onkeyup="filterAdmins()" placeholder="Search..." class="w-full pl-9 pr-3 py-2.5 bg-slate-50 border rounded-full text-[13px] focus:outline-none focus:border-zinc-900">
                    </div>
                </div>
                <div class="overflow-x-auto hide-scroll no-scrollbar">
                    <table class="w-full text-left min-w-[700px]">
                        <thead class="bg-slate-50 text-[11px] font-bold text-slate-500 uppercase tracking-wider border-b">
                            <tr><th class="px-5 py-3">ID</th><th class="px-5 py-3">User Name</th><th class="px-5 py-3">Email</th><th class="px-5 py-3">Role</th><th class="px-5 py-3">Active</th><th class="px-5 py-3">Contact</th><th class="px-5 py-3">Action</th></tr>
                        </thead>
                        <tbody class="text-[13px]">
                            <c:forEach var="a" items="${adminList}">
                                <tr class="border-b border-slate-100 hover:bg-slate-50/50 adminRow last:border-0 ${a.id == sessionScope.adminId ? 'bg-zinc-50/80' : ''}">
                                    <td class="px-5 py-4 text-slate-500">${a.id}</td>
                                    <td class="px-5 py-4 font-semibold">${a.user_name} <c:if test="${a.id == sessionScope.adminId}"><span class="ml-2 bg-zinc-900 text-white text-[9px] px-2 py-0.5 rounded-full">YOU</span></c:if></td>
                                    <td class="px-5 py-4 text-slate-600">${a.email}</td>
                                    <td class="px-5 py-4"><c:if test="${a.role == 'SUPER_ADMIN'}"><span class="bg-zinc-900 text-white px-2.5 py-1 rounded-full text-[10px] font-bold">SUPER_ADMIN</span></c:if><c:if test="${a.role == 'ADMIN'}"><span class="bg-slate-100 border px-2.5 py-1 rounded-full text-[10px] font-bold">ADMIN</span></c:if></td>
                                    <td class="px-5 py-4"><c:choose><c:when test="${a.active}"><span class="bg-emerald-100 text-emerald-700 border border-emerald-200 px-2.5 py-1 rounded-full text-[10px] font-bold">ACTIVE</span></c:when><c:otherwise><span class="bg-red-100 text-red-600 border border-red-200 px-2.5 py-1 rounded-full text-[10px] font-bold">INACTIVE</span></c:otherwise></c:choose></td>
                                    <td class="px-5 py-4">${a.contact}</td>
                                    <td class="px-5 py-4">
                                        <div class="flex gap-1.5">
                                            <c:choose>
                                                <c:when test="${a.id == sessionScope.adminId}">
                                                    <button onclick="openViewModal('${a.id}','${a.user_name}','${a.email}','${a.contact}','${a.dob}','${a.address}','${a.role}','${a.active}')" class="w-8 h-8 bg-zinc-900 text-white rounded-lg flex items-center justify-center"><i class="fa-solid fa-eye text-xs"></i></button>
                                                </c:when>
                                                <c:otherwise>
                                                    <button onclick="openViewModal('${a.id}','${a.user_name}','${a.email}','${a.contact}','${a.dob}','${a.address}','${a.role}','${a.active}')" class="w-8 h-8 bg-slate-50 border rounded-lg flex items-center justify-center"><i class="fa-solid fa-eye text-xs"></i></button>
                                                    <c:if test="${a.role != 'SUPER_ADMIN'}">
                                                        <a href="${pageContext.request.contextPath}/LoadUpdateAdminProfile?id=${a.id}" class="w-8 h-8 bg-amber-50 text-amber-600 border border-amber-100 rounded-lg flex items-center justify-center"><i class="fa-solid fa-pen text-xs"></i></a>
                                                        <button onclick="openDeleteModal('${a.id}')" class="w-8 h-8 bg-red-50 text-red-600 border border-red-100 rounded-lg flex items-center justify-center"><i class="fa-solid fa-trash text-xs"></i></button>
                                                    </c:if>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>
</div>

<!-- Add Modal -->
<div id="addAdminModal" class="fixed inset-0 bg-black/50 z-[60] hidden items-center justify-center p-4">
    <div class="bg-white rounded-[24px] w-full max-w-lg max-h-[90vh] overflow-y-auto no-scrollbar border shadow-2xl">
        <div class="p-5 border-b flex items-center justify-between sticky top-0 bg-white rounded-t-[24px]"><h3 class="font-bold">Add New Admin</h3><button onclick="closeAddModal()" class="w-8 h-8 bg-slate-100 rounded-full border"><i class="fa-solid fa-xmark text-xs"></i></button></div>
        <form action="${pageContext.request.contextPath}/AddAdmin" method="post" class="p-5 space-y-4">
            <div class="grid grid-cols-2 gap-4">
                <div class="col-span-2"><label class="text-xs font-semibold text-slate-500">User Name *</label><input type="text" name="user_name" required class="w-full mt-1 px-4 py-2.5 bg-slate-50 border rounded-xl text-[13px]"></div>
                <div class="col-span-2"><label class="text-xs font-semibold text-slate-500">Email *</label><input type="email" name="email" required class="w-full mt-1 px-4 py-2.5 bg-slate-50 border rounded-xl text-[13px]"></div>
                <div><label class="text-xs font-semibold text-slate-500">Password *</label><input type="password" name="password" required class="w-full mt-1 px-4 py-2.5 bg-slate-50 border rounded-xl text-[13px]"></div>
                <div><label class="text-xs font-semibold text-slate-500">Contact *</label><input type="text" name="contact" required class="w-full mt-1 px-4 py-2.5 bg-slate-50 border rounded-xl text-[13px]"></div>
                <div class="col-span-2"><label class="text-xs font-semibold text-slate-500">DOB *</label><input type="date" name="dob" required class="w-full mt-1 px-4 py-2.5 bg-slate-50 border rounded-xl text-[13px]"></div>
                <div class="col-span-2"><label class="text-xs font-semibold text-slate-500">Address *</label><textarea name="address" required rows="2" class="w-full mt-1 px-4 py-2.5 bg-slate-50 border rounded-xl text-[13px]"></textarea></div>
                <div><label class="text-xs font-semibold text-slate-500">Role *</label><select name="role" class="w-full mt-1 px-4 py-2.5 bg-slate-50 border rounded-xl text-[13px]"><option value="SUPER_ADMIN">SUPER_ADMIN</option><option value="ADMIN" selected>ADMIN</option></select></div>
                <div><label class="text-xs font-semibold text-slate-500">Active *</label><select name="active" class="w-full mt-1 px-4 py-2.5 bg-slate-50 border rounded-xl text-[13px]"><option value="true" selected>ACTIVE</option><option value="false">INACTIVE</option></select></div>
            </div>
            <button type="submit" class="w-full bg-zinc-900 text-white py-3 rounded-xl text-[14px] font-semibold">Create Admin</button>
        </form>
    </div>
</div>

<!-- View Modal -->
<div id="viewAdminModal" class="fixed inset-0 bg-black/60 backdrop-blur-sm z-[60] hidden items-center justify-center p-4">
    <div class="bg-white rounded-[28px] w-full max-w-lg shadow-2xl flex flex-col" style="animation: scaleIn 0.3s ease;">
        <div class="h-[88px] bg-gradient-to-br from-zinc-900 via-zinc-800 to-black relative shrink-0 rounded-t-[28px]">
            <div class="absolute -bottom-8 left-5 w-[72px] h-[72px] rounded-[14px] border-[3px] border-white bg-black text-white flex items-center justify-center font-extrabold text-[22px] shadow-xl z-10" id="v_avatar">A</div>
        </div>
        <div class="px-6 pt-10 pb-6 rounded-b-[28px] bg-white">
            <div class="flex flex-wrap items-center gap-2"><h3 class="text-[19px] font-extrabold tracking-tight text-zinc-900" id="v_name">Admin</h3><span id="v_active_badge"></span></div>
            <div class="grid grid-cols-2 gap-3 mt-4">
                <div class="bg-[#f6f7fb] rounded-2xl p-4 border"><p class="text-[10px] tracking-widest text-slate-400 font-bold">ID</p><p class="font-bold mt-1 text-[15px]" id="v_id">2</p></div>
                <div class="rounded-2xl p-4 border shadow-sm" id="v_active_card"><p class="text-[10px] tracking-widest font-bold flex items-center gap-1.5" id="v_active_label"><i class="fa-solid fa-signal"></i> STATUS</p><p class="font-extrabold mt-1.5 text-[13px] flex items-center gap-2"><span class="w-2 h-2 rounded-full animate-pulse" id="v_active_pulse"></span><span id="v_active_text">INACTIVE</span></p></div>
                <div class="bg-[#f6f7fb] rounded-2xl p-4 border col-span-2"><p class="text-[10px] tracking-widest text-slate-400 font-bold">EMAIL</p><p class="font-semibold mt-1.5 text-[13px] break-all" id="v_email"></p></div>
                <div class="bg-[#f6f7fb] rounded-2xl p-4 border"><p class="text-[10px] tracking-widest text-slate-400 font-bold">CONTACT</p><p class="font-semibold mt-1.5 text-[13px]" id="v_contact"></p></div>
                <div class="bg-[#f6f7fb] rounded-2xl p-4 border"><p class="text-[10px] tracking-widest text-slate-400 font-bold">DOB</p><p class="font-semibold mt-1.5 text-[13px]" id="v_dob"></p></div>
                <div class="bg-[#f6f7fb] rounded-2xl p-4 border col-span-2"><p class="text-[10px] tracking-widest text-slate-400 font-bold">ADDRESS</p><p class="font-medium mt-1.5 text-[13px]" id="v_address"></p></div>
            </div>
            <button onclick="closeViewModal()" class="w-full mt-5 py-3 rounded-full bg-zinc-900 text-white font-bold text-[13px] hover:bg-black transition">Close</button>
        </div>
    </div>
</div>

<!-- Delete Modal + Hidden POST Form -->
<div id="deleteModal" class="fixed inset-0 bg-black/50 hidden items-center justify-center z-[70] p-4">
  <div class="bg-white rounded-[20px] p-6 w-full max-w-sm shadow-2xl">
    <div class="w-12 h-12 bg-red-100 text-red-500 rounded-full flex items-center justify-center mx-auto mb-4"><i class="fa-regular fa-trash-can"></i></div>
    <h3 class="text-center font-bold text-[16px]">Delete this Admin?</h3>
    <form id="deleteForm" action="${pageContext.request.contextPath}/DeleteAdmin" method="post">
        <input type="hidden" name="id" id="deleteIdInput">
        <div class="flex gap-3 mt-6">
          <button type="button" onclick="closeDeleteModal()" class="flex-1 py-2.5 rounded-full bg-slate-100 font-bold text-[13px] border">Cancel</button>
          <button type="submit" class="flex-1 py-2.5 rounded-full bg-red-500 text-white font-bold text-[13px]">Delete</button>
        </div>
    </form>
  </div>
</div>

<script>
let deleteId = null;
function filterAdmins(){ let input = document.getElementById("searchInput").value.toLowerCase(); document.querySelectorAll(".adminRow").forEach(r => { r.style.display = r.innerText.toLowerCase().includes(input) ? "" : "none"; }); }
function openAddModal(){ document.getElementById('addAdminModal').classList.remove('hidden'); document.getElementById('addAdminModal').classList.add('flex'); }
function closeAddModal(){ document.getElementById('addAdminModal').classList.add('hidden'); document.getElementById('addAdminModal').classList.remove('flex'); }
function openDeleteModal(id){ deleteId=id; document.getElementById('deleteIdInput').value=id; document.getElementById('deleteModal').classList.remove('hidden'); document.getElementById('deleteModal').classList.add('flex'); }
function closeDeleteModal(){ document.getElementById('deleteModal').classList.add('hidden'); document.getElementById('deleteModal').classList.remove('flex'); deleteId=null; }
function toggleSidebar(){ const sb=document.querySelector('aside'); const bd=document.getElementById('sidebarBackdrop'); if(sb){ sb.classList.toggle('-translate-x-full'); if(bd) bd.classList.toggle('hidden'); } }
function openViewModal(id,name,email,contact,dob,address,role,active){
    document.getElementById('v_id').innerText = id; document.getElementById('v_name').innerText = name; document.getElementById('v_avatar').innerText = name.charAt(0).toUpperCase();
    document.getElementById('v_email').innerText = email; document.getElementById('v_contact').innerText = contact || 'N/A'; document.getElementById('v_dob').innerText = dob || 'N/A'; document.getElementById('v_address').innerText = address || 'N/A';
    let isActive = (active == true || active == 'true' || active == '1'); let activeBadge = document.getElementById('v_active_badge'); let activeCard = document.getElementById('v_active_card'); let activeLabel = document.getElementById('v_active_label'); let activeText = document.getElementById('v_active_text'); let activePulse = document.getElementById('v_active_pulse');
    if(isActive){ activeBadge.className = 'text-[10px] px-3 py-1 rounded-full font-bold tracking-widest flex items-center gap-1.5 bg-emerald-500 text-white'; activeBadge.innerHTML = '<i class="fa-solid fa-circle-check"></i> ACTIVE'; activeCard.className = 'rounded-2xl p-4 border shadow-sm bg-gradient-to-br from-emerald-50 to-green-50 border-emerald-200'; activeLabel.className = 'text-[10px] tracking-widest font-bold flex items-center gap-1.5 text-emerald-600'; activeLabel.innerHTML = '<i class="fa-solid fa-signal"></i> STATUS'; activeText.innerText = 'ACTIVE'; activeText.className = 'text-emerald-700 font-extrabold'; activePulse.className = 'w-2 h-2 rounded-full animate-pulse bg-emerald-500'; }
    else { activeBadge.className = 'text-[10px] px-3 py-1 rounded-full font-bold tracking-widest flex items-center gap-1.5 bg-red-500 text-white'; activeBadge.innerHTML = '<i class="fa-solid fa-circle-xmark"></i> INACTIVE'; activeCard.className = 'rounded-2xl p-4 border shadow-sm bg-gradient-to-br from-red-50 to-orange-50 border-red-200'; activeLabel.className = 'text-[10px] tracking-widest font-bold flex items-center gap-1.5 text-red-500'; activeLabel.innerHTML = '<i class="fa-solid fa-signal"></i> STATUS'; activeText.innerText = 'INACTIVE'; activeText.className = 'text-red-600 font-extrabold'; activePulse.className = 'w-2 h-2 rounded-full bg-red-500'; }
    document.getElementById('viewAdminModal').classList.remove('hidden'); document.getElementById('viewAdminModal').classList.add('flex');
}
function closeViewModal(){ document.getElementById('viewAdminModal').classList.add('hidden'); document.getElementById('viewAdminModal').classList.remove('flex'); }
</script>
</body>
</html>