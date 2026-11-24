<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="sidebarBackdrop" onclick="toggleSidebar()" class="fixed inset-0 bg-black/40 z-40 hidden md:hidden"></div>

<aside id="sidebar" class="fixed md:sticky top-0 left-0 w-[260px] min-w-[260px] max-w-[260px] h-screen bg-[#0f172a] text-white z-50 -translate-x-full md:translate-x-0 transition-transform duration-300 flex flex-col">
    
    <div class="p-6 flex items-center justify-between shrink-0">
        <div class="flex items-center gap-3">
            <div class="w-10 h-10 bg-white rounded-xl flex items-center justify-center text-[#0f172a] text-lg shrink-0"><i class="fa-solid fa-user-graduate"></i></div>
            <div>
                <h1 class="font-bold leading-none text-[16px]">StudentMS</h1>
                <p class="text-[11px] text-slate-400 mt-1 tracking-wider uppercase"> STUDENT PANEL </p>
            </div>
        </div>
        <button onclick="toggleSidebar()" class="md:hidden w-8 h-8 bg-white/10 rounded-lg shrink-0"><i class="fa-solid fa-xmark"></i></button>
    </div>

    <nav class="px-4 mt-3 space-y-1.5 flex-1 overflow-y-auto no-scrollbar" id="sidebarNav">
        <a href="${pageContext.request.contextPath}/Student/student-dashboard.jsp" data-path="student-dashboard" class="nav-item flex items-center gap-3 px-3.5 py-3.5 text-slate-400 hover:text-white hover:bg-white/5 rounded-xl text-[15px] font-medium transition"><i class="fa-solid fa-table-columns w-5 text-[16px]"></i> Dashboard</a>
        <a href="${pageContext.request.contextPath}/LoadStudenProfile?id=${sessionScope.student.id}" data-path="loadstudenprofile" class="nav-item flex items-center gap-3 px-3.5 py-3.5 text-slate-400 hover:text-white hover:bg-white/5 rounded-xl text-[15px] font-medium transition"><i class="fa-solid fa-users w-5 text-[16px]"></i> My Profile</a>
        <a href="${pageContext.request.contextPath}/Student/student-course-profile.jsp" data-path="student-course-profile" class="nav-item flex items-center gap-3 px-3.5 py-3.5 text-slate-400 hover:text-white hover:bg-white/5 rounded-xl text-[15px] font-medium transition"><i class="fa-solid fa-book w-5 text-[16px]"></i>My Course</a>
        <a href="${pageContext.request.contextPath}/student-fee-report" data-path="student-fee-report" class="nav-item flex items-center gap-3 px-3.5 py-3.5 text-slate-400 hover:text-white hover:bg-white/5 rounded-xl text-[15px] font-medium transition"><i class="fa-solid fa-indian-rupee-sign w-5 text-[16px]"></i>Fee & Reports</a>
       
        <a href="${pageContext.request.contextPath}/update-password" data-path="update-password" class="nav-item flex items-center gap-3 px-3.5 py-3.5 text-slate-400 hover:text-white hover:bg-white/5 rounded-xl text-[15px] font-medium transition"><i class="fa-solid fa-key w-5 text-[16px]"></i> Change Password</a>
    </nav>

    <div class="p-4 border-t border-white/10 shrink-0 mt-auto bg-[#0f172a]">
        <div class="bg-white/5 rounded-2xl p-3 flex items-center gap-3">
            <img src="https://i.pravatar.cc/100?u=${sessionScope.student.id}" class="w-9 h-9 rounded-full">
            <div class="flex-1 min-w-0">
                <p class="text-sm font-semibold truncate">${sessionScope.student.full_name}</p>
                <p class="text-[11px] text-slate-400 flex items-center gap-1">
                  ${sessionScope.role}
                  <c:if test="${sessionScope.role == 'STUDENT'}"><span class="w-1.5 h-1.5 bg-amber-400 rounded-full animate-pulse"></span></c:if>
                </p>
            </div>
            <a href="${pageContext.request.contextPath}/logout" class="w-8 h-8 bg-white/10 hover:bg-red-500 rounded-lg flex items-center justify-center"><i class="fa-solid fa-right-from-bracket text-xs"></i></a>
        </div>
    </div>
</aside>

<script>
(function(){
    const navItems = document.querySelectorAll(".nav-item");
    const path = window.location.pathname.toLowerCase();
    function setActive(el){
        navItems.forEach(e => {
            e.className = "nav-item flex items-center gap-3 px-3.5 py-3.5 text-slate-400 hover:text-white hover:bg-white/5 rounded-xl text-[15px] font-medium transition";
        });
        el.className = "nav-item flex items-center gap-3 px-3.5 py-3.5 rounded-xl text-[15px] font-semibold transition bg-white text-[#0f172a]";
    }
    let bestMatch = null, bestLen = -1;
    navItems.forEach(item => {
        let p = (item.dataset.path || "").toLowerCase();
        if(!p) return;
        let match = path.includes(p);
        if(match && p.length > bestLen){
            bestLen = p.length;
            bestMatch = item;
        }
    });
    if(bestMatch) setActive(bestMatch);

    // Click karte hi turant white kar do, page load ka wait mat karo
    navItems.forEach(item => {
        item.addEventListener('click', function(){
            setActive(item);
        });
    });
})();
function toggleSidebar(){
    const s=document.getElementById('sidebar'), b=document.getElementById('sidebarBackdrop');
    if(s.classList.contains('-translate-x-full')){s.classList.remove('-translate-x-full');b.classList.remove('hidden');}
    else{s.classList.add('-translate-x-full');b.classList.add('hidden');}
}
</script>