<header class="sticky top-0 z-30 bg-white/80 backdrop-blur-xl border-b border-slate-200 px-4 md:px-8 py-4 flex items-center justify-between gap-4">
    <div class="flex items-center gap-3">
        <button onclick="toggleSidebar()" class="md:hidden w-10 h-10 bg-slate-900 text-white rounded-xl"><i class="fa-solid fa-bars"></i></button>
        <div>
            <h2 class="font-bold text-[16px] md:text-xl leading-none">Dashboard</h2>
            <p class="hidden md:block text-xs text-slate-500 mt-1">Welcome back, manage your students</p>
        </div>
    </div>
    <div class="flex items-center gap-2">
        <div class="hidden md:flex items-center gap-2 bg-slate-100 rounded-full pl-3 pr-2 py-1.5">
            <i class="fa-solid fa-magnifying-glass text-slate-400 text-xs"></i>
            <input placeholder="Search..." class="bg-transparent outline-none text-sm w-32">
        </div>
        <!-- YAHI CHANGE HAI - Servlet ko call karega, JSP ko nahi -->
        <a href="${pageContext.request.contextPath}//LoadAddServlet" class="bg-blue-600 hover:bg-blue-700 text-white px-4 md:px-5 py-2.5 rounded-full md:rounded-xl text-[13px] font-semibold shadow-lg shadow-blue-200">
            <i class="fa-solid fa-plus mr-1"></i> <span class="hidden md:inline">Add Student</span><span class="md:hidden">Add</span>
        </a>
    </div>
</header>