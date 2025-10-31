import stripe
import json
import os
import sys

def main():
    if len(sys.argv) < 3:
        sys.ext(1)

    data_file = sys.argv[1]
    output_file = sys.argv[2]
    stripe.api_key = os.getenv('STRIPE_SECRET_KEY')

    with open(data_file) as f:
        products = json.load(f)

    checkout_links = {}

    for product in products:
        stripe_product = stripe.Product.create(
            name=product['name'],
            description=product.get('note', f"${product['price']}")
        )

        price = stripe.Price.create(
            product=stripe_product.id,
            unit_amount=int(product['price'] * 100),
            currency='usd'
        )

        session = stripe.checkout.Session.create(
            payment_method_types=['card', 'paypal'],
            line_items=[{
                'price': price.id,
                'quantity': 1
            }],
            mode='payment',
            success_url='https://faycarsons.github.io/synths-for-sale',
            cancel_url='https://faycarsons.github.io/synths-for-sale'
        )

        checkout_links[product['name']] = session.url

    with open(output_file, 'w') as f:
        json.dump(checkout_links, f, indent=2)

    print('Generated payment links')


if __name__ == "__main__":
    main()
