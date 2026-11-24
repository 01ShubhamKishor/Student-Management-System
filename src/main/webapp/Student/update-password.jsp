<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String role = (String) session.getAttribute("role");
    if(role == null || !"STUDENT".equals(role)){
        response.sendRedirect(request.getContextPath()+"/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Password | StudentMS</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>body{font-family:'Inter',sans-serif} .no-scrollbar::-webkit-scrollbar{display:none} .no-scrollbar{-ms-overflow-style:none;scrollbar-width:none}</style>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body class="bg-[#f6f7fb] text-slate-900">

<!-- POPUP -->
<% if(session.getAttribute("passUpdated") != null) { %>
<script>
Swal.fire({ title: "Success!", text: "Password updated successfully", icon: "success", timer: 2000, showConfirmButton: false });
</script>
<% session.removeAttribute("passUpdated"); %>
<% } %>
<% if(request.getAttribute("error") != null) { %>
<script>
Swal.fire({ title: "Error!", text: "${error}", icon: "error" });
</script>
<% } %>

<div class="flex min-h-screen">
    <!-- ===== SIDEBAR INCLUDE ===== -->
    <jsp:include page="student-sidebar.jsp" />

    <main class="flex-1 min-w-0">
      <!-- ===== TOP NAV ===== -->
      <div class="sticky top-0 z-10 bg-white/90 backdrop-blur border-b px-4 py-3 flex items-center justify-between">
        <div class="flex items-center gap-3">
          <button onclick="toggleSidebar()" class="lg:hidden w-9 h-9 grid place-items-center rounded-xl bg-slate-900 text-white">
            <i class="fa-solid fa-bars"></i>
          </button>
          <h2 class="font-bold text-[16px]">Update Password</h2>
        </div>
        <a href="student-dashboard.jsp" class="text-xs bg-slate-900 text-white px-3 py-2 rounded-full">Back to Dashboard</a>
      </div>

      <div class="p-4 lg:p-6 max-w-2xl mx-auto">
        <div class="bg-white rounded-[24px] border shadow-sm overflow-hidden">
          <div class="h-24 bg-gradient-to-r from-slate-900 via-slate-800 to-indigo-700 flex items-center px-6 gap-4">
            <div class="w-12 h-12 rounded-2xl bg-white/20 backdrop-blur grid place-items-center text-white text-xl">
                <i class="fa-solid fa-key"></i>
            </div>
            <div>
                <h3 class="text-white font-bold text-lg leading-none">Change Your Password</h3>
                <p class="text-white/70 text-xs mt-1">Keep your account safe, strong password rakho.</p>
            </div>
          </div>

          <form action="${pageContext.request.contextPath}/update-password" method="post" class="p-5 sm:p-6 space-y-4" onsubmit="return validatePass()">

            <div>
                <label class="text-[11px] tracking-widest text-slate-400 font-bold">CURRENT PASSWORD</label>
                <div class="relative mt-1">
                    <input type="password" id="currentPass" name="currentPassword" required placeholder="Enter current password"
                        class="w-full bg-[#f6f7fb] rounded-2xl px-4 py-3 text-sm font-medium outline-none focus:ring-2 focus:ring-slate-900 pr-11" />
                    <button type="button" onclick="toggleEye('currentPass', this)" class="absolute right-3 top-1/2 -translate-y-1/2 text-slate-400"><i class="fa-solid fa-eye"></i></button>
                </div>
            </div>

            <div>
                <label class="text-[11px] tracking-widest text-slate-400 font-bold">NEW PASSWORD</label>
                <div class="relative mt-1">
                    <input type="password" id="newPass" name="newPassword" required placeholder="Min 6 characters"
                        class="w-full bg-[#f6f7fb] rounded-2xl px-4 py-3 text-sm font-medium outline-none focus:ring-2 focus:ring-slate-900 pr-11" />
                    <button type="button" onclick="toggleEye('newPass', this)" class="absolute right-3 top-1/2 -translate-y-1/2 text-slate-400"><i class="fa-solid fa-eye"></i></button>
                </div>
                <p id="passStrength" class="text-[11px] font-bold mt-1 text-slate-400"></p>
            </div>

            <div>
                <label class="text-[11px] tracking-widest text-slate-400 font-bold">CONFIRM NEW PASSWORD</label>
                <div class="relative mt-1">
                    <input type="password" id="confirmPass" name="confirmPassword" required placeholder="Re-enter new password"
                        class="w-full bg-[#f6f7fb] rounded-2xl px-4 py-3 text-sm font-medium outline-none focus:ring-2 focus:ring-slate-900 pr-11" />
                    <button type="button" onclick="toggleEye('confirmPass', this)" class="absolute right-3 top-1/2 -translate-y-1/2 text-slate-400"><i class="fa-solid fa-eye"></i></button>
                </div>
                <p id="matchMsg" class="text-[11px] font-bold mt-1"></p>
            </div>

            <button type="submit" class="w-full bg-slate-900 hover:bg-black text-white font-bold py-3.5 rounded-2xl text-sm transition flex items-center justify-center gap-2">
                <i class="fa-solid fa-lock"></i> Update Password
            </button>

            <p class="text-center text-[11px] text-slate-400">you can may re-login after changing your password .</p>
          </form>
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
function toggleEye(id, btn){
    const inp = document.getElementById(id);
    if(inp.type === 'password'){ inp.type='text'; btn.innerHTML='<i class="fa-solid fa-eye-slash"></i>'; }
    else{ inp.type='password'; btn.innerHTML='<i class="fa-solid fa-eye"></i>'; }
}
document.getElementById('newPass').addEventListener('input', function(){
    const v = this.value;
    const el = document.getElementById('passStrength');
    if(v.length === 0){ el.textContent=''; }
    else if(v.length < 6){ el.textContent='Weak - Kam se kam 6 character'; el.className='text-[11px] font-bold mt-1 text-red-500'; }
    else if(v.length < 10){ el.textContent='Good'; el.className='text-[11px] font-bold mt-1 text-amber-500'; }
    else{ el.textContent='Strong'; el.className='text-[11px] font-bold mt-1 text-emerald-500'; }
});
function validatePass(){
    const np = document.getElementById('newPass').value;
    const cp = document.getElementById('confirmPass').value;
    const msg = document.getElementById('matchMsg');
    if(np.length < 6){ Swal.fire({title:'Error!', text:'New password must contain 6 character', icon:'error'}); return false; }
    if(np !== cp){ msg.textContent='Password not matched!'; msg.className='text-[11px] font-bold mt-1 text-red-500'; Swal.fire({title:'Error!', text:'New password & Confirm password are not same', icon:'error'}); return false; }
    return true;
}
</script>
</body>
</html>