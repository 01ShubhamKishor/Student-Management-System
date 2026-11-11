<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Student | StudentMS</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>body{font-family:'Inter',sans-serif}</style>
</head>
<body class="bg-[#f6f7fb] text-slate-900">

<div class="flex min-h-screen">
    <div id="sidebarBackdrop" onclick="toggleSidebar()" class="fixed inset-0 bg-black/40 z-40 hidden md:hidden"></div>
   <jsp:include page="sidebar.jsp"></jsp:include>

    <main class="flex-1 min-w-0">
        <header class="sticky top-0 z-30 bg-white/80 backdrop-blur-xl border-b border-slate-200 px-4 md:px-8 py-4 flex items-center gap-3">
            <button onclick="toggleSidebar()" class="md:hidden w-10 h-10 bg-slate-900 text-white rounded-xl"><i class="fa-solid fa-bars"></i></button>
            <a href="admin-homepage.jsp" class="md:hidden w-10 h-10 bg-slate-100 rounded-xl flex items-center justify-center"><i class="fa-solid fa-arrow-left text-sm"></i></a>
            <div>
                <h2 class="font-bold text-[16px] md:text-xl leading-none">Add New Student</h2>
                <p class="hidden md:block text-xs text-slate-500 mt-1">Fill details to register student</p>
            </div>
        </header>

        <div class="p-4 md:p-8 max-w-5xl mx-auto">
            <form action="${pageContext.request.contextPath}/AddStudent" method="post" enctype="multipart/form-data" class="bg-white rounded-[24px] md:rounded-[28px] border border-slate-100 shadow-sm overflow-hidden">
                
                <div class="p-5 md:p-8 border-b border-slate-100 flex flex-col md:flex-row items-start md:items-center gap-5">
                    <div class="relative">
                        <img id="previewImg" src="https://i.pravatar.cc/200?img=0" class="w-20 h-20 md:w-24 md:h-24 rounded-[20px] object-cover bg-slate-100">
                        <label class="absolute -bottom-2 -right-2 w-8 h-8 bg-blue-600 text-white rounded-full flex items-center justify-center shadow-lg cursor-pointer hover:bg-blue-700">
                            <i class="fa-solid fa-camera text-[12px]"></i>
                            <input type="file" name="photo" accept="image/*" onchange="previewFile()" class="hidden">
                        </label>
                    </div>
                    <div id="feeBox" class="hidden bg-blue-50 border border-blue-100 rounded-xl px-4 py-3">
                        <p class="text-[11px] font-bold text-blue-600 uppercase">Selected Course Fee</p>
                        <p id="feeText" class="text-[16px] font-extrabold text-slate-900">₹ 0</p>
                        <p id="semHint" class="text-[11px] text-slate-500 mt-1"></p>
                    </div>
                </div>

                <div class="p-5 md:p-8 space-y-6">
                    <div>
                        <h4 class="font-bold text-[13px] tracking-wider text-slate-400 uppercase mb-4 flex items-center gap-2"><span class="w-6 h-6 bg-slate-900 text-white rounded-full flex items-center justify-center text-[11px]">1</span> Personal Info</h4>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div class="col-span-1 md:col-span-2">
                                <label class="text-[12px] font-semibold text-slate-600">Full Name *</label>
                                <input name="full_name" required placeholder="Rahul Sharma" class="mt-1.5 w-full px-4 py-3.5 bg-slate-50 border border-slate-200 rounded-2xl text-[14px] focus:outline-none focus:border-blue-600 focus:bg-white transition">
                            </div>
                            <div>
                                <label class="text-[12px] font-semibold text-slate-600">Roll Number *</label>
                                <input name="roll_no" required placeholder="CS2024005" class="mt-1.5 w-full px-4 py-3.5 bg-slate-50 border border-slate-200 rounded-2xl text-[14px]">
                            </div>
                            <div>
                                <label class="text-[12px] font-semibold text-slate-600">Phone *</label>
                                <input name="phone" required type="tel" maxlength="10" placeholder="98765 43210" class="mt-1.5 w-full px-4 py-3.5 bg-slate-50 border border-slate-200 rounded-2xl text-[14px]">
                            </div>
                            <div>
                                <label class="text-[12px] font-semibold text-slate-600">Email</label>
                                <input name="email" type="email" placeholder="rahul@email.com" class="mt-1.5 w-full px-4 py-3.5 bg-slate-50 border border-slate-200 rounded-2xl text-[14px]">
                            </div>
                            <div>
                                <label class="text-[12px] font-semibold text-slate-600">Date of Birth</label>
                                <input name="dob" type="date" class="mt-1.5 w-full px-4 py-3.5 bg-slate-50 border border-slate-200 rounded-2xl text-[14px]">
                            </div>
                        </div>
                    </div>

                    <div>
                        <h4 class="font-bold text-[13px] tracking-wider text-slate-400 uppercase mb-4 flex items-center gap-2"><span class="w-6 h-6 bg-slate-900 text-white rounded-full flex items-center justify-center text-[11px]">2</span> Academic</h4>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label class="text-[12px] font-semibold text-slate-600">Course *</label>
                                <select id="courseSelect" name="course_code" required onchange="handleCourseChange()" class="mt-1.5 w-full px-4 py-3.5 bg-slate-50 border border-slate-200 rounded-2xl text-[14px] font-semibold">
                                    <option value="">Select Course</option>
                                    <c:forEach var="c" items="${courseList}">
                                        <option value="${c.COURSE_CODE}" data-fee="${c.FEE}" data-duration="${c.DURATION_YEAR}" data-total-sem="${c.TOTAL_SEMESTER}">${c.COURSE_CODE} - ${c.COURSE} (${c.TOTAL_SEMESTER} Sem)</option>
                                    </c:forEach>
                                </select>
                                <c:if test="${empty courseList}">
                                    <p class="text-[11px] text-red-500 mt-2 font-bold">No active course found! Pehle course add karo.</p>
                                </c:if>
                            </div>
                            <div>
                                <label class="text-[12px] font-semibold text-slate-600">Semester *</label>
                                <select id="semesterSelect" name="semester" required class="mt-1.5 w-full px-4 py-3.5 bg-slate-50 border border-slate-200 rounded-2xl text-[14px]">
                                    <option value="">Select Course First</option>
                                </select>
                            </div>
                            <div>
                                <label class="text-[12px] font-semibold text-slate-600">Admission Year *</label>
                                <input name="admissionYear" type="number" min="2000" max="2030" value="2026" required class="mt-1.5 w-full px-4 py-3.5 bg-slate-50 border border-slate-200 rounded-2xl text-[14px]">
                            </div>
                            <div>
                                <label class="text-[12px] font-semibold text-slate-600">Status *</label>
                                <select name="status" required class="mt-1.5 w-full px-4 py-3.5 bg-slate-50 border border-slate-200 rounded-2xl text-[14px]">
                                    <option value="ACTIVE" selected>ACTIVE</option>
                                </select>
                            </div>
                            <div class="col-span-1 md:col-span-2">
                                <label class="text-[12px] font-semibold text-slate-600">Address</label>
                                <textarea name="address" rows="2" placeholder="House no, Street, City" class="mt-1.5 w-full px-4 py-3.5 bg-slate-50 border border-slate-200 rounded-2xl text-[14px] resize-none"></textarea>
                            </div>
                        </div>
                    </div>

                    <div class="flex gap-3 pt-2">
                        <a href="admin-homepage.jsp" class="flex-1 md:flex-none px-6 py-3.5 bg-slate-100 text-slate-700 rounded-2xl text-[14px] font-bold text-center">Cancel</a>
                        <button type="submit" class="flex-[2] md:flex-none md:ml-auto px-8 py-3.5 bg-[#0f172a] text-white rounded-2xl text-[14px] font-bold flex items-center justify-center gap-2">
                            <i class="fa-solid fa-check"></i> Save Student
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </main>
</div>

<script>
function toggleSidebar(){
    const s=document.getElementById('sidebar'), b=document.getElementById('sidebarBackdrop');
    if(!s) return;
    s.classList.contains('-translate-x-full') ? (s.classList.remove('-translate-x-full'), b.classList.remove('hidden')) : (s.classList.add('-translate-x-full'), b.classList.add('hidden'));
}
function previewFile(){
    const file = event.target.files[0];
    if(file){
        const reader = new FileReader();
        reader.onload = e => document.getElementById('previewImg').src = e.target.result;
        reader.readAsDataURL(file);
    }
}

function handleCourseChange(){
    const sel = document.getElementById('courseSelect');
    const opt = sel.options[sel.selectedIndex];
    const feeBox = document.getElementById('feeBox');
    const semSelect = document.getElementById('semesterSelect');
    
    if(!opt || !opt.value){
        feeBox.classList.add('hidden');
        semSelect.innerHTML = '<option value="">Pehle course select karo</option>';
        return;
    }

    const fee = opt.getAttribute('data-fee');
    const years = opt.getAttribute('data-duration');
    const totalSem = parseInt(opt.getAttribute('data-total-sem')) || 0;

    if(fee){
        feeBox.classList.remove('hidden');
        document.getElementById('feeText').innerText = '₹ ' + fee;
        document.getElementById('semHint').innerText = years + ' Years = ' + totalSem + ' Semesters (from TOTAL_SEMESTER)';
    }

    semSelect.innerHTML = '';
    if(totalSem > 0){
        for(let i=1; i<=totalSem; i++){
            const o = document.createElement('option');
            o.value = i;
            o.textContent = i + (i==1?'st':i==2?'nd':i==3?'rd':'th') + ' Sem';
            semSelect.appendChild(o);
        }
    } else {
        semSelect.innerHTML = '<option>No semester found for this course</option>';
    }
}
</script>
</body>
</html>