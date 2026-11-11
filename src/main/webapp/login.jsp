<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login | Student Management System</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style> body { font-family: 'Inter', sans-serif; }</style>
</head>
<!-- MOBILE PE BG BLUE KAR DIYA -->
<body class="bg-[#0f172a] md:bg-[#2B2422] min-h-screen flex items-center justify-center md:p-4 p-4">

    <div class="w-full md:max-w-5xl bg-white md:rounded-[32px] rounded-[28px] shadow-2xl overflow-hidden grid grid-cols-1 md:grid-cols-2">
        
        <!-- LEFT BLUE PART -->
        <div class="bg-gradient-to-br from-blue-600 to-indigo-700 relative p-8 md:p-10 flex flex-col justify-between min-h-[200px] md:min-h-[640px] rounded-b-[28px] md:rounded-b-none md:rounded-l-[32px]">
            <div class="absolute -top-20 -right-20 w-64 h-64 bg-white/10 rounded-full blur-2xl"></div>
            
            <div class="relative z-10">
                <div class="flex items-center gap-2">
                    <div class="w-9 h-9 bg-white rounded-xl flex items-center justify-center text-blue-600 font-bold"><i class="fa-solid fa-user-graduate"></i></div>
                    <h1 class="text-xl font-bold text-white">Student System Management</h1>
                </div>
                <div class="mt-8 md:mt-20">
                    <h2 class="text-[28px] md:text-[40px] font-bold leading-[1.1] text-white">Welcome<br>Back!</h2>
                    <p class="mt-3 text-[14px] text-blue-100 max-w-[280px]">Your Oragnization are waiting. Login to continue.</p>
                </div>
            </div>
            <div class="hidden md:block relative z-10 text-xs text-blue-200">© 2026 Student Management Inc.</div>
        </div>

        <!-- RIGHT WHITE PART - AB MARGIN KE SATH FLOATING -->
        <!-- Mobile pe ispe margin hai kyunki parent pe p-4 hai aur ye rounded hai -->
        <div class="p-6 md:p-12 flex flex-col justify-center bg-white">
            <h2 class="text-[22px] font-bold text-slate-900">Login to your account</h2>
            <p class="text-slate-500 mt-1.5 mb-7 text-[14px]">Don't have an account? <a href="register.jsp" class="text-blue-600 font-semibold">Sign up for free</a></p>

            <c:if test="${not empty errorMsg}">
                <div class="bg-red-50 border border-red-100 text-red-600 text-[13px] p-3.5 rounded-xl mb-6 flex gap-2">
                    <i class="fa-solid fa-circle-exclamation mt-0.5"></i> ${errorMsg}
                </div>
            </c:if>

           
            <form action="login" method="post" class="space-y-5">
                <div>
                    <label class="block text-[13px] font-semibold text-slate-700 mb-2">Email Address</label>
                    <div class="relative">
                        <span class="absolute left-4 top-1/2 -translate-y-1/2 text-slate-400"><i class="fa-regular fa-envelope"></i></span>
                        <input type="email" name="email" required
                            class="w-full pl-11 pr-4 py-3.5 rounded-xl border border-slate-200 bg-slate-50 focus:bg-white focus:border-blue-500 focus:ring-4 focus:ring-blue-50 outline-none text-[16px]"
                            placeholder="you@example.com">
                    </div>
                </div>
                <div>
                    <div class="flex justify-between mb-2">
                        <label class="text-[13px] font-semibold text-slate-700">Password</label>
                        <a href="#" class="text-[12px] font-medium text-blue-600">Forgot?</a>
                    </div>
                    <div class="relative">
                        <span class="absolute left-4 top-1/2 -translate-y-1/2 text-slate-400"><i class="fa-solid fa-lock text-[14px]"></i></span>
                        <input type="password" id="pass" name="password" required
                            class="w-full pl-11 pr-11 py-3.5 rounded-xl border border-slate-200 bg-slate-50 focus:bg-white focus:border-blue-500 focus:ring-4 focus:ring-blue-50 outline-none text-[16px]"
                            placeholder="••••••••">
                        <button type="button" onclick="togglePass()" class="absolute right-4 top-1/2 -translate-y-1/2 text-slate-400">
                            <i id="eyeIcon" class="fa-regular fa-eye"></i>
                        </button>
                    </div>
                </div>
                <button type="submit" class="w-full bg-[#2563eb] hover:bg-[#1d4ed8] text-white font-semibold py-4 rounded-xl shadow-[0_8px_20px_rgba(37,99,235,0.3)] active:scale-[0.98] text-[15px]">
                    Login <i class="fa-solid fa-arrow-right ml-2 text-xs"></i>
                </button>
            </form>
        </div>
    </div>

<script>
function togglePass(){
    let p=document.getElementById('pass'), icon=document.getElementById('eyeIcon');
    if(p.type==='password'){p.type='text';icon.classList.replace('fa-eye','fa-eye-slash');}
    else{p.type='password';icon.classList.replace('fa-eye-slash','fa-eye');}
}
</script>
</body>
</html>