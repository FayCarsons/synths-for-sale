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
        size: (
            stripe.ShippingRate.create(
                display_name=f'{size} Item Shipping',
                type='fixed_amount',
                fixed_amount={
                    'amount': int(rate) * 100,
                    'currency': 'usd'
                }
            ).id
        ) if size != 'Small' else None
        for size,rate in json.load(open(shipping_path)).items()
    }

    if not stripe.api_key:
        raise ValueError("Stripe key env var not set")

    with open(synths_path) as f:
        products = json.load(f)

    checkout_links = {}

    for product in products:
        stripe_product = None
        description = product.get('note', None)

        if description is not None:
            stripe_product = stripe.Product.create(
                name=product['name'],
                description=description
            )
        else:
            stripe_product = stripe.Product.create(
                name=product['name'],
            )

        stripe_price = stripe.Price.create(
            product=stripe_product.id,
            unit_amount=int(product['price'] * 100),
            currency='usd'
        )

        size = product['size']
        shipping_options = []
        
        if size and size in shipping_rates and shipping_rates[size] is not None:
            shipping_options = [{'shipping_rate': shipping_rates[size]}]

        payment_link_params = {
            'line_items': [{
                "price": stripe_price.id, 
                "quantity": 1
            }],
            'shipping_address_collection': {"allowed_countries": ["US"]},
            'after_completion': { "type": "redirect", "redirect": {
                "url": 
                "https://faycarsons.github.io/synths-for-sale"} 
            }
        }

        if shipping_options: 
            payment_link_params['shipping_options'] = shipping_options

        payment_link = stripe.PaymentLink.create(**payment_link_params)
        checkout_links[product['name']] = payment_link.url

    with open(checkout_path, 'w') as f:
        json.dump(checkout_links, f, indent=2)

if __name__ == "__main__":
    main()
