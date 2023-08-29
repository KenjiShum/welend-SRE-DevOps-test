import requests
from bs4 import BeautifulSoup
from collections import Counter
import re

def fetch_page_content(url):
    """Fetch the page content."""
    response = requests.get(url)
    response.raise_for_status()
    return response.content

def parse_page_content(content):
    """Parse the page content."""
    soup = BeautifulSoup(content, 'html.parser')
    text = soup.get_text()
    return text

def get_words(text):
    """Get the words from the text."""
    return re.findall(r'\b\w+\b', text)

def count_word_frequency(words):
    """Count the frequency of each word."""
    return Counter(words)

def find_most_common_words(word_counts):
    """Find the words that occurred the most."""
    max_count = max(word_counts.values())
    most_common_words = [word for word, count in word_counts.items() if count == max_count]
    return most_common_words, max_count

def main(url):
    content = fetch_page_content(url)
    text = parse_page_content(content)
    words = get_words(text)
    word_counts = count_word_frequency(words)
    most_common_words, max_count = find_most_common_words(word_counts)

    # Print the words and their frequency
    for word in most_common_words:
        print(f'{word}: {max_count}')

main('http://localhost:80')