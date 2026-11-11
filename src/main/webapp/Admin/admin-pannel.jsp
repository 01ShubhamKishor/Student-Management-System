<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String role = (String) session.getAttribute("role");
    if(role == null || (!"ADMIN".equals(role) && !"SUPER_ADMIN".equals(role))){
        response.sendRedirect(request.getContextPath()+"/login.jsp");
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
    <style> body{font-family:'Inter',sans-serif} </style>
</head>
<body class="bg-[#f6f7fb] text-slate-900">
<div class="flex min-h-screen">
     <jsp:include page="sidebar.jsp"></jsp:include>
    <main class="flex-1 min-w-0 flex flex-col">
     <jsp:include page="navbar.jsp"></jsp:include>

<div class="flex-1 p-4 md:p-8 space-y-6 max-w-[1400px] mx-auto w-full">

    <!-- TOP ACHIEVEMENT -->
    <div class="bg-white rounded-[24px] md:rounded-[28px] border border-slate-100 p-5 md:p-7 shadow-sm relative overflow-hidden">
        <div class="absolute top-0 right-0 w-64 h-64 bg-gradient-to-br from-blue-50 to-violet-50 rounded-full blur-3xl -mr-20 -mt-20 pointer-events-none"></div>
        <div class="relative">
            <div class="flex justify-between items-start">
                <div>
                    <span class="bg-[#0f172a] text-white text-[10px] font-bold tracking-widest px-3 py-1 rounded-full">ACHIEVEMENTS • 2026</span>
                    <h3 class="font-extrabold text-[18px] md:text-[22px] mt-3 leading-tight">Institute Growth & Milestones</h3>
                </div>
                <div class="w-10 h-10 md:w-12 md:h-12 bg-amber-100 text-amber-600 rounded-2xl flex items-center justify-center text-lg"><i class="fa-solid fa-trophy"></i></div>
            </div>
            <div class="grid grid-cols-3 gap-2.5 md:gap-4 mt-5 md:mt-7">
                <div class="bg-slate-50 border border-slate-100 rounded-2xl p-3 md:p-4">
                    <p class="text-[10px] md:text-[11px] font-bold text-slate-400 uppercase tracking-wider">Success Rate</p>
                    <p class="text-[20px] md:text-[28px] font-extrabold mt-1">94<span class="text-[14px]">%</span></p>
                    <p class="text-[10px] md:text-[11px] text-emerald-600 font-bold mt-1"><i class="fa-solid fa-arrow-trend-up"></i> +6% growth</p>
                </div>
                <div class="bg-slate-50 border border-slate-100 rounded-2xl p-3 md:p-4">
                    <p class="text-[10px] md:text-[11px] font-bold text-slate-400 uppercase tracking-wider">Placements</p>
                    <p class="text-[20px] md:text-[28px] font-extrabold mt-1">128</p>
                    <p class="text-[10px] md:text-[11px] text-blue-600 font-bold mt-1"><i class="fa-solid fa-briefcase"></i> Top MNCs</p>
                </div>
                <div class="bg-slate-50 border border-slate-100 rounded-2xl p-3 md:p-4">
                    <p class="text-[10px] md:text-[11px] font-bold text-slate-400 uppercase tracking-wider">Avg Package</p>
                    <p class="text-[20px] md:text-[28px] font-extrabold mt-1">₹6.2<span class="text-[12px] font-bold">L</span></p>
                    <p class="text-[10px] md:text-[11px] text-violet-600 font-bold mt-1"><i class="fa-solid fa-star"></i> High ₹18L</p>
                </div>
            </div>
            <div class="mt-5 flex items-center gap-3 text-[11px] md:text-[12px]">
                <div class="flex -space-x-2">
                    <img src="https://i.pravatar.cc/32?u=1" class="w-6 h-6 md:w-7 md:h-7 rounded-full border-2 border-white">
                    <img src="https://i.pravatar.cc/32?u=2" class="w-6 h-6 md:w-7 md:h-7 rounded-full border-2 border-white">
                    <img src="https://i.pravatar.cc/32?u=3" class="w-6 h-6 md:w-7 md:h-7 rounded-full border-2 border-white">
                </div>
                <p class="text-slate-500 font-medium"><span class="font-bold text-slate-900">${totalStudents} Students</span> trusted this year</p>
            </div>
        </div>
    </div>

    <!-- TOP 4 STATS -->
    <div class="grid grid-cols-2 lg:grid-cols-4 gap-3 md:gap-4">
        <div class="bg-white rounded-[20px] p-4 md:p-5 border border-slate-100 shadow-sm">
            <div class="flex justify-between items-start">
                <div class="w-10 h-10 bg-blue-50 text-blue-600 rounded-xl flex items-center justify-center"><i class="fa-solid fa-users"></i></div>
                <span class="text-[11px] font-bold text-green-600 bg-green-50 px-2 py-1 rounded-full">+12%</span>
            </div>
            <p class="text-[22px] md:text-2xl font-extrabold mt-3">${totalStudents}</p>
            <p class="text-[12px] text-slate-500 font-medium">Total Students</p>
        </div>
        <div class="bg-white rounded-[20px] p-4 md:p-5 border border-slate-100 shadow-sm">
            <div class="flex justify-between items-start">
                <div class="w-10 h-10 bg-violet-50 text-violet-600 rounded-xl flex items-center justify-center"><i class="fa-solid fa-book-open"></i></div>
                <span class="text-[11px] font-bold text-violet-600 bg-violet-50 px-2 py-1 rounded-full">Active</span>
            </div>
            <p class="text-[22px] md:text-2xl font-extrabold mt-3">${activeCourses}</p>
            <p class="text-[12px] text-slate-500 font-medium">Active Courses</p>
        </div>
        <div class="bg-white rounded-[20px] p-4 md:p-5 border border-slate-100 shadow-sm">
            <div class="flex justify-between items-start">
                <div class="w-10 h-10 bg-green-50 text-green-600 rounded-xl flex items-center justify-center"><i class="fa-solid fa-indian-rupee-sign"></i></div>
                <span class="text-[11px] font-bold text-green-600 bg-green-50 px-2 py-1 rounded-full">Paid</span>
            </div>
            <p class="text-[22px] md:text-2xl font-extrabold mt-3"><fmt:formatNumber value="${totalFeecollected}" groupingUsed="true" /></p>
            <p class="text-[12px] text-slate-500 font-medium">Fees Collected</p>
        </div>
        <div class="bg-[#0f172a] text-white rounded-[20px] p-4 md:p-5 shadow-sm border border-slate-800">
            <div class="flex justify-between items-start">
                <div class="w-10 h-10 bg-white/10 rounded-xl flex items-center justify-center"><i class="fa-solid fa-user-check"></i></div>
                <span class="text-[11px] font-bold text-emerald-300 bg-white/10 px-2 py-1 rounded-full">Live</span>
            </div>
            <p class="text-[22px] md:text-2xl font-extrabold mt-3">${totalActiveStudentCount}</p>
            <p class="text-[12px] text-slate-400 font-medium">Present Today</p>
        </div>
    </div>

    <!-- STUDENT OVERVIEW -->
    <div>
        <h3 class="font-bold text-[16px] mb-4">Student Overview</h3>
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-4">
            <div onclick="location.href='GetAllStudents?status=ACTIVE'" class="cursor-pointer group bg-white rounded-[24px] border border-slate-100 p-5 shadow-sm hover:shadow-xl hover:-translate-y-1 transition-all">
                <div class="flex justify-between items-start mb-4">
                    <div class="w-12 h-12 bg-emerald-50 text-emerald-600 rounded-2xl flex items-center justify-center text-lg"><i class="fa-solid fa-user-graduate"></i></div>
                    <span class="bg-emerald-50 text-emerald-700 text-[11px] font-bold px-3 py-1 rounded-full">${totalActiveStudentCount} Students</span>
                </div>
                <h4 class="font-extrabold text-[18px]">Active Students</h4>
                <p class="text-[13px] text-slate-500 mt-1">Currently studying and attending classes.</p>
                <div class="mt-4"><div class="flex justify-between text-[11px] font-bold text-slate-400 mb-1.5"><span>Progress</span><span>85%</span></div><div class="w-full bg-slate-100 rounded-full h-2"><div class="bg-emerald-500 h-2 rounded-full" style="width:85%"></div></div></div>
                <div class="mt-5 flex items-center gap-2 text-[13px] font-bold text-emerald-600 group-hover:gap-3 transition-all">View All Active <i class="fa-solid fa-arrow-right text-xs"></i></div>
            </div>
            <div onclick="location.href='GetAllStudents?status=PASSOUT'" class="cursor-pointer group bg-white rounded-[24px] border border-slate-100 p-5 shadow-sm hover:shadow-xl hover:-translate-y-1 transition-all">
                <div class="flex justify-between items-start mb-4">
                    <div class="w-12 h-12 bg-blue-50 text-blue-600 rounded-2xl flex items-center justify-center text-lg"><i class="fa-solid fa-award"></i></div>
                    <span class="bg-blue-50 text-blue-700 text-[11px] font-bold px-3 py-1 rounded-full">Completed</span>
                </div>
                <h4 class="font-extrabold text-[18px]">Passout Students</h4>
                <p class="text-[13px] text-slate-500 mt-1">Successfully graduated and completed course.</p>
                <div class="mt-4 grid grid-cols-3 gap-2">
                    <div class="bg-slate-50 rounded-xl p-2.5 text-center"><p class="text-[16px] font-extrabold">${passoutCount != null ? passoutCount : 0}</p><p class="text-[10px] text-slate-500 font-bold uppercase">Total</p></div>
                    <div class="bg-slate-50 rounded-xl p-2.5 text-center"><p class="text-[16px] font-extrabold">92%</p><p class="text-[10px] text-slate-500 font-bold uppercase">Result</p></div>
                    <div class="bg-slate-50 rounded-xl p-2.5 text-center"><p class="text-[16px] font-extrabold">2026</p><p class="text-[10px] text-slate-500 font-bold uppercase">Batch</p></div>
                </div>
                <div class="mt-5 flex items-center gap-2 text-[13px] font-bold text-blue-600 group-hover:gap-3 transition-all">View Passout List <i class="fa-solid fa-arrow-right text-xs"></i></div>
            </div>
            <div onclick="location.href='GetAllStudents?status=DROPOUT'" class="cursor-pointer group bg-white rounded-[24px] border border-slate-100 p-5 shadow-sm hover:shadow-xl hover:-translate-y-1 transition-all">
                <div class="flex justify-between items-start mb-4">
                    <div class="w-12 h-12 bg-red-50 text-red-500 rounded-2xl flex items-center justify-center text-lg"><i class="fa-solid fa-user-xmark"></i></div>
                    <span class="bg-red-50 text-red-600 text-[11px] font-bold px-3 py-1 rounded-full">Attention</span>
                </div>
                <h4 class="font-extrabold text-[18px]">Dropout Students</h4>
                <p class="text-[13px] text-slate-500 mt-1">Left the course in middle due to reasons.</p>
                <div class="mt-4 bg-red-50 border border-red-100 rounded-xl p-3 flex items-center gap-3">
                    <div class="w-8 h-8 bg-white rounded-full grid place-items-center text-red-500"><i class="fa-solid fa-triangle-exclamation text-xs"></i></div>
                    <div><p class="text-[12px] font-bold text-red-700 leading-none">Needs Follow-up</p><p class="text-[11px] text-red-600/70 mt-1">Contact & counseling required</p></div>
                </div>
                <div class="mt-5 flex items-center gap-2 text-[13px] font-bold text-red-600 group-hover:gap-3 transition-all">View Dropout List <i class="fa-solid fa-arrow-right text-xs"></i></div>
            </div>
        </div>
    </div>

</div>

<!-- FOOTER - MOBILE ONLY -->
<footer class="lg:hidden mt-6">
    <div class="mx-4 mb-4 bg-[#0f172a] rounded-[24px] p-5 text-white">
        <div class="flex items-center justify-between">
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 bg-white text-slate-900 rounded-xl flex items-center justify-center"><i class="fa-solid fa-graduation-cap"></i></div>
                <div>
                    <p class="font-extrabold text-[14px] leading-none">StudentMS</p>
                    <p class="text-[11px] text-slate-400 mt-1">Admin Panel • v2.0</p>
                </div>
            </div>
            <span class="text-[10px] font-bold bg-white/10 px-3 py-1.5 rounded-full">© 2026</span>
        </div>
        <div class="mt-4 grid grid-cols-3 gap-2">
            <div class="bg-white/5 rounded-xl p-2.5 text-center border border-white/10">
                <i class="fa-solid fa-bolt text-amber-400 text-xs"></i>
                <p class="text-[11px] font-bold mt-1">Fast</p>
            </div>
            <div class="bg-white/5 rounded-xl p-2.5 text-center border border-white/10">
                <i class="fa-solid fa-shield-halved text-emerald-400 text-xs"></i>
                <p class="text-[11px] font-bold mt-1">Secure</p>
            </div>
            <div class="bg-white/5 rounded-xl p-2.5 text-center border border-white/10">
                <i class="fa-solid fa-heart text-red-400 text-xs"></i>
                <p class="text-[11px] font-bold mt-1">Trusted</p>
            </div>
        </div>
        <p class="text-center text-[10px] text-slate-500 mt-4 tracking-wider">MADE WITH ❤️ FOR STUDENTS</p>
    </div>
</footer>

    </main>
</div>
</body>
</html>