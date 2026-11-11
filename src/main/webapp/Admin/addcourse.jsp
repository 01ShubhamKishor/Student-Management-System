<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Course | StudentMS</title>
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
                <h2 class="text-[16px] md:text-xl font-bold flex items-center gap-2"><i class="fa-solid fa-book-open text-blue-600"></i> Add New Course</h2>
                <p class="text-[12px] text-slate-500 mt-0.5">Fill all details to create a new course - Code will be unique</p>
            </div>
        </header>

        <div class="p-3 md:p-8 max-w-3xl mx-auto">
            <div class="md:hidden flex items-center gap-2 mb-4">
                <div class="flex-1 h-1.5 bg-blue-600 rounded-full"></div>
                <div class="flex-1 h-1.5 bg-slate-200 rounded-full"></div>
                <span class="text-[11px] font-bold text-slate-500 ml-2">STEP 1 OF 2</span>
            </div>

            <div class="bg-white rounded-[24px] border border-slate-100 shadow-sm p-5 md:p-8">
             <form action="${pageContext.request.contextPath}/AddCourse" method="post" class="space-y-5">
            
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <label class="text-[11px] font-bold text-slate-600 uppercase">Course Code * (Unique)</label>
                        <input type="text" id="course_code" name="course_code" placeholder="Ex: BTECH-CSE" required 
                        pattern="[A-Z0-9-]+" title="Only Capital Letters, Numbers and - allowed"
                        class="mt-1.5 w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-[14px] font-bold uppercase focus:outline-none focus:ring-2 focus:ring-blue-500">
                        <p class="text-[10px] text-slate-400 mt-1">Ex: BTECH-CSE, BCA-GEN - Yehi student_details me jayega</p>
                    </div>
                    <div>
                        <label class="text-[11px] font-bold text-slate-600 uppercase">Course Name *</label>
                        <input type="text" name="course" placeholder="Ex: B.Tech" required
                        class="mt-1.5 w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-[14px] focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <label class="text-[11px] font-bold text-slate-600 uppercase">Department *</label>
                        <select name="department" required class="mt-1.5 w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-[14px] focus:outline-none">
                            <option value="">Select Department</option>
                            <option value="Computer Science">Computer Science</option>
                            <option value="Information Technology">Information Technology</option>
                            <option value="Electronics & Communication">Electronics & Communication</option>
                            <option value="Mechanical Engineering">Mechanical Engineering</option>
                            <option value="Civil Engineering">Civil Engineering</option>
                            <option value="Business Administration">Business Administration</option>
                            <option value="Commerce">Commerce</option>
                            <option value="Arts">Arts</option>
                            <option value="Pharmacy">Pharmacy</option>
                            <option value="Law">Law</option>
                        </select>
                    </div>
                    <div>
                        <label class="text-[11px] font-bold text-slate-600 uppercase">Fees Per Year *</label>
                        <input type="number" name="fee" placeholder="Ex: 120000" required min="1000"
                        class="mt-1.5 w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-[14px] focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <label class="text-[11px] font-bold text-slate-600 uppercase">Duration (Year) *</label>
                        <input type="number" id="duration_year" name="duration_year" placeholder="Ex: 4" min="1" max="6" required
                        class="mt-1.5 w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-[14px] focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                    <div>
                        <label class="text-[11px] font-bold text-slate-600 uppercase">Total Semester *</label>
                        <input type="number" id="total_semester" name="total_semester" placeholder="Ex: 8" min="1" max="12" required
                        class="mt-1.5 w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-[14px] focus:outline-none focus:ring-2 focus:ring-blue-500">
                        <p class="text-[10px] text-slate-400 mt-1">Auto-fill hoga duration se</p>
                    </div>
                </div>

                <div>
                    <label class="text-[11px] font-bold text-slate-600 uppercase">Description</label>
                    <textarea name="description" rows="3" placeholder="Write about course..."
                    class="mt-1.5 w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-[14px] focus:outline-none focus:ring-2 focus:ring-blue-500"></textarea>
                </div>

                <div class="flex items-center gap-3 bg-blue-50 p-3 rounded-xl border border-blue-100">
                    <input type="checkbox" name="active" value="1" checked id="active" class="w-5 h-5 accent-blue-600">
                    <label for="active" class="text-[13px] font-semibold">Is Course Active? (Active course hi student form me dikhega)</label>
                </div>

                <div class="flex gap-3 pt-2">
                    <button type="submit" class="flex-1 bg-blue-600 hover:bg-blue-700 text-white font-bold py-3.5 rounded-xl text-[14px] transition">
                        <i class="fa-solid fa-plus mr-2"></i> Add Course
                    </button>
                    <a href="adminHome.jsp" class="px-6 bg-slate-100 hover:bg-slate-200 font-bold py-3.5 rounded-xl text-[14px] text-slate-700 flex items-center justify-center">Cancel</a>
                </div>

            </form>
            </div>
            
            <p class="text-center text-[11px] text-slate-400 mt-6">All fields with * are required.</p>
        </div>
    </main>
</div>

<script>
function toggleSidebar(){
    const s=document.getElementById('sidebar'), b=document.getElementById('sidebarBackdrop');
    if(!s) return;
    s.classList.contains('-translate-x-full') ? (s.classList.remove('-translate-x-full'), b.classList.remove('hidden')) : (s.classList.add('-translate-x-full'), b.classList.add('hidden'));
}

// Auto Uppercase COURSE_CODE
document.getElementById('course_code').addEventListener('input', function(){
    this.value = this.value.toUpperCase().replace(/[^A-Z0-9-]/g, '');
});

// Duration se Semester auto
document.getElementById('duration_year').addEventListener('input', function(){
    let year = parseInt(this.value);
    if(year > 0){
        document.getElementById('total_semester').value = year * 2;
    }
});
</script>
</body>
</html>