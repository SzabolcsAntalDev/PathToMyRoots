namespace PathToMyRootsWebApp.Utils
{
    public static class StringMixins
    {
        public static bool ContainsIgnoreCase(this string text, string filterText)
        {
            if (string.IsNullOrEmpty(text))
                return false;

            if (string.IsNullOrEmpty(filterText))
                return true;

            return text.Contains(filterText, StringComparison.OrdinalIgnoreCase);
        }
    }
}
