$(document).ready(function() {
    function loadAllMedicalData() {
        $.ajax({
            url: '/medical',
            type: 'GET',
            success: function(data) {
                $('#medicalTable tbody').html(data.medical_table_html);
            }
        });
    }
    function loadMedicalData(serial) {
        $.ajax({
            url: '/medical',
            type: 'POST',
            data: { serial: serial },
            success: function(data) {
                $('#medicalTable tbody').html(data.medical_table_html || '');
            }
            
            
        });
    }

    // Submit form event
    $('#searchForm').submit(function(e) {
        e.preventDefault();
        var serial = $('#serialInput').val();
        if (serial.toLowerCase() === "all") {
            loadAllMedicalData();
        } else {
            loadMedicalData(serial); // Load medical data based on input serial
        }
    });

    // Live search while typing
    $('#serialInput').on('input', function() {
        var serial = $(this).val();
        if (serial.toLowerCase() === "all") {
            loadAllMedicalData();
        } else {
            loadMedicalData(serial); // Load medical data based on input serial
        }
    });

    // Initial load of all medical data
    loadMedicalData('');
});
