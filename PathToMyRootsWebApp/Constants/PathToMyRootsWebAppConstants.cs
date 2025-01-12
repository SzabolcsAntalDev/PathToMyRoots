namespace PathToMyRootsWebApp.Constants
{
    public static class PathToMyRootsWebAppConstants
    {
        public const string HumanReadableDateFormat = "yyyy. MM. dd.";
        public const string HumanReadableDateStillAlive = "still alive";
        public const string HumanReadableDateUnknownDate = "?";

        public static readonly DateTime UnknownDate = new(1753, 1, 1);

        public const string ValueNotAvailable = "N/A";
        public const string UnknownValue = "Unknown";
        public const int UnsetIntValue = -1;
    }
}
