import stripe
import json
import os
import sys

def main():
    if len(sys.argv) < 2:
        raise ValueError("Not enough arguments - expected data directory")

    data_dir = sys.argv[1]
    shipping_path = data_dir + '/shipping.json'
    synths_path = data_dir + '/synths.json'
    checkout_path = data_dir + '/checkoutLinks.json'

    stripe.api_key = os.getenv('STRIPE_SECRET_KEY')


    shipping_rates = {
        size: {
            'type': 'fixed_amount',
            'fixed_amount': { 'amount': amount, 'currency': 'usd' },
            'display_name': 'shipping'
        } if size != 'small' else None
        for size,rate in json.load(open(shipping_path)).items()
    }

    if not stripe.api_key:
        raise ValueError("Stripe key env var not set")

    with open(synths_path) as f:
        products = json.load(f)

    checkout_links = {}

    for product in products:
        session = stripe.checkout.Session.create(
            payment_method_types=[
            'card', 
            #'paypal',
            'affirm',
            'klarna',
            'link',
            'cashapp', 
            'crypto'
            ],
            line_items=[{
                'price_data': {
                    'currency': 'usd',
                    'product_data': {
                        'name': product['name'],
                        'description': product.get('note', f"${product['price']}")
                    },
                    'unit_amount': int(product['price'] * 100)
                },
                'quantity': 1
            }],
            shipping_rate_data=shipping_rates[product['size']],
            mode='payment',
            success_url='https://faycarsons.github.io/synths-for-sale',
            cancel_url='https://faycarsons.github.io/synths-for-sale'
        )

        checkout_links[product['name']] = session.url

    with open(checkout_path, 'w') as f:
        json.dump(checkout_links, f, indent=2)

if __name__ == "__main__":
    main()
