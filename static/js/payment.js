document.addEventListener('DOMContentLoaded', function() {
    // Show/hide payment fields based on selected payment method
    document.getElementById('paymentMethod').addEventListener('change', function() {
        var selectedPayment = this.value;
        // Hide all payment fields
        document.getElementById('creditCardFields').style.display = 'none';
        document.getElementById('paypalFields').style.display = 'none';
        document.getElementById('bankTransferFields').style.display = 'none';
        // Show fields based on selected payment method
        if (selectedPayment === 'cc') {
            document.getElementById('creditCardFields').style.display = 'block';
        } else if (selectedPayment === 'paypal') {
            document.getElementById('paypalFields').style.display = 'block';
        } else if (selectedPayment === 'bank_transfer') {
            document.getElementById('bankTransferFields').style.display = 'block';
        }
    });
    // Submit form event listener
    document.querySelector('form').addEventListener('submit', function(e) {
        e.preventDefault(); // Prevent form submission
        var donationAmount = document.getElementById('donation_amount').value;
        var paymentMethod = document.getElementById('paymentMethod').value;
        
        if (paymentMethod === 'default') {
            alert('Please select a valid payment method.');
            return;
        }
        // process payment here according to payment method
            // to-do: implement payment processing
        
        // modal to show payment status
        var modal = new bootstrap.Modal(document.getElementById('donationModal'), {
            keyboard: false
        });
        var modalContent = document.getElementById('donationInfo');
        modalContent.textContent = 'Billed $' + donationAmount + ' on Payment Method ' + paymentMethod;
        modal.show();
    });
});
$(document).ready(function() {
    $('#paymentMethod').on('change', function() {
        var selectedPaymentMethod = $(this).val();

        // Hide all payment fields and remove the required attribute
        $('#creditCardFields, #paypalFields, #bankTransferFields').hide();
        $('#creditCardFields input, #paypalFields input, #bankTransferFields input').removeAttr('required');

        // Show and set required attribute for the selected payment method's fields
        if (selectedPaymentMethod === 'cc') {
            $('#creditCardFields').show();
            $('#creditCardFields input').attr('required', 'required');
        } else if (selectedPaymentMethod === 'paypal') {
            $('#paypalFields').show();
            $('#paypalFields input').attr('required', 'required');
        } else if (selectedPaymentMethod === 'bank_transfer') {
            $('#bankTransferFields').show();
            $('#bankTransferFields input').attr('required', 'required');
        }
    });
});
