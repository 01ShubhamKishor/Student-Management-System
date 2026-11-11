<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form action="${pageContext.request.contextPath}/AddFee" method="post" class="space-y-4" id="feeForm">
    <div class="col-span-2 relative">
        <label class="text-[11px] font-bold tracking-widest text-slate-400">SEARCH STUDENT (ID / Name)</label>
        <input type="text" id="studentSearch" autocomplete="off" placeholder="Type ID or Name... e.g. 101" 
               class="w-full mt-1.5 bg-[#f6f7fb] border border-slate-200 rounded-xl px-4 py-3 text-sm outline-none focus:border-slate-900 focus:bg-white transition">
        <div id="suggestionBox" class="absolute z-50 w-full mt-2 bg-white border border-slate-200 rounded-2xl shadow-xl max-h-[220px] overflow-auto hidden"></div>
        <input type="hidden" name="studentId" id="selected_student_id" required>
    </div>

    <div class="grid grid-cols-2 gap-4">
        <div>
            <label class="text-[11px] font-bold tracking-widest text-slate-400">STUDENT NAME</label>
            <input type="text" id="student_name_display" readonly class="w-full mt-1.5 bg-slate-50 border border-slate-200 rounded-xl px-4 py-3 text-sm text-slate-600">
        </div>
        <div>
            <label class="text-[11px] font-bold tracking-widest text-slate-400">COURSE CODE</label>
            <input type="text" id="course_code_display" name="courseCode" readonly class="w-full mt-1.5 bg-slate-50 border border-slate-200 rounded-xl px-4 py-3 text-sm font-bold">
        </div>
        <div>
            <label class="text-[11px] font-bold tracking-widest text-slate-400">TOTAL FEE (₹)</label>
            <input type="number" id="total_fee_display" name="totalFee" readonly class="w-full mt-1.5 bg-slate-50 border border-slate-200 rounded-xl px-4 py-3 text-sm font-bold">
        </div>
        <div>
            <label class="text-[11px] font-bold tracking-widest text-slate-400">PAID AMOUNT (₹)</label>
            <input type="number" id="paid_fee_input" name="paidFee" required oninput="calcDue()" placeholder="₹ Amount" class="w-full mt-1.5 bg-[#f6f7fb] border border-slate-200 rounded-xl px-4 py-3 text-sm outline-none focus:border-emerald-500 focus:bg-white font-bold">
        </div>
        <div>
            <label class="text-[11px] font-bold tracking-widest text-slate-400">DUE AUTO (₹)</label>
            <input type="number" id="due_fee_display" name="dueFee" readonly class="w-full mt-1.5 bg-red-50 border border-red-200 rounded-xl px-4 py-3 text-sm font-bold text-red-600">
        </div>
        <div>
            <label class="text-[11px] font-bold tracking-widest text-slate-400">PAYMENT MODE</label>
            <select name="paymentMode" class="w-full mt-1.5 bg-[#f6f7fb] border border-slate-200 rounded-xl px-4 py-3 text-sm outline-none focus:border-slate-900">
                <option value="CASH">CASH</option>
                <option value="UPI">UPI</option>
                <option value="CARD">CARD</option>
                <option value="NETBANKING">NET BANKING</option>
            </select>
        </div>
        <div class="col-span-2">
            <label class="text-[11px] font-bold tracking-widest text-slate-400">PAYMENT DATE</label>
            <input type="date" name="paymentDate" required value="<%= java.time.LocalDate.now() %>" class="w-full mt-1.5 bg-[#f6f7fb] border border-slate-200 rounded-xl px-4 py-3 text-sm outline-none focus:border-slate-900">
        </div>
    </div>
    <button type="submit" class="w-full bg-emerald-600 hover:bg-emerald-700 text-white py-3.5 rounded-xl text-sm font-bold shadow-sm transition">
        <i class="fa-solid fa-check mr-2"></i> Submit Fee
    </button>
</form>

<script>
const allStudents = [
    <c:forEach var="st" items="${allStudents}" varStatus="loop">
    {id: "${st.ID}", name: "${st.FULL_NAME}", course: "${st.COURSE_CODE}", fee: "${st.COURSE_FEE}"}<c:if test="${!loop.last}">,</c:if>
    </c:forEach>
];

const searchInput = document.getElementById('studentSearch');
const suggestionBox = document.getElementById('suggestionBox');

if(searchInput){
    searchInput.addEventListener('input', function(){
        const query = this.value.toLowerCase();
        suggestionBox.innerHTML = "";
        if(query.length < 1){ suggestionBox.classList.add('hidden'); return; }
        const filtered = allStudents.filter(s => s.id.toLowerCase().includes(query) || s.name.toLowerCase().includes(query)).slice(0, 20);
        if(filtered.length > 0){
            filtered.forEach(s => {
                const div = document.createElement('div');
                div.className = "px-4 py-3 hover:bg-slate-50 cursor-pointer border-b last:border-0 text-sm flex justify-between items-center";
                div.innerHTML = `<span><b>\${s.id}</b> - \${s.name}</span><span class="text-[11px] bg-slate-100 px-2 py-1 rounded-full">\${s.course} ₹\${s.fee}</span>`;
                div.onclick = () => selectStudent(s);
                suggestionBox.appendChild(div);
            });
            suggestionBox.classList.remove('hidden');
        } else { suggestionBox.classList.add('hidden'); }
    });
    
    document.addEventListener('click', function(e){
        if(!searchInput.contains(e.target) && !suggestionBox.contains(e.target)){
            suggestionBox.classList.add('hidden');
        }
    });
}

function selectStudent(s){
    document.getElementById('selected_student_id').value = s.id;
    document.getElementById('studentSearch').value = s.id + " - " + s.name;
    document.getElementById('student_name_display').value = s.name;
    document.getElementById('course_code_display').value = s.course;
    document.getElementById('total_fee_display').value = s.fee;
    suggestionBox.classList.add('hidden');
    calcDue();
    document.getElementById('paid_fee_input').focus();
}
function calcDue(){
    const total = parseInt(document.getElementById('total_fee_display').value) || 0;
    const paid = parseInt(document.getElementById('paid_fee_input').value) || 0;
    const due = total - paid;
    document.getElementById('due_fee_display').value = due < 0 ? 0 : due;
}
window.openAddFee = function(id){
    if(typeof showView === 'function') showView('addFeeView');
    const s = allStudents.find(x => x.id == id);
    if(s) selectStudent(s);
    window.scrollTo({top: 0, behavior: 'smooth'});
}
</script>