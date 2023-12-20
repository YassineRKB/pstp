$(document).ready(function() {
    // Event listener for filter changes
    $('#species-filter, #status-filter, #gender-filter').on('change', function() {
        // Create an object to store filter values
        let filters = {
            species: $('#species-filter').val(),
            status: $('#status-filter').val(),
            gender: $('#gender-filter').val()
        };

        // Send a POST request to /pets with filter data
        $.ajax({
            url: '/pets',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(filters),
            success: function(response) {
                // Replace pet cards with updated data
                $('#pet-cards').html(response);
            },
            error: function(error) {
                console.error('Error:', error);
                alert('An error occurred. Please try again.');
            }
        });
    });
});
