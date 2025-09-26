public class DiscountService {
// Returns a discount percent by revenue and industry
public static Decimal calcDiscount(Decimal annualRevenue, String industry) {
if (annualRevenue == null) annualRevenue = 0;
if (String.isBlank(industry)) industry = 'Other';

Decimal base = 0; // default
if (annualRevenue >= 10000000) { // >= 1 crore
base = 0.15;
} else if (annualRevenue >= 1000000) { // >= 10 lakh
base = 0.10;
} else {
base = 0.05;
}

// Small bonus for Tech
base += (industry == 'Technology') ? 0.02 : 0.00;
return base.setScale(2); // 2 decimal places
}
}