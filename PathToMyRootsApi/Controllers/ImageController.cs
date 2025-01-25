using Microsoft.AspNetCore.Mvc;

namespace PathToMyRootsApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ImageController : ControllerBase
    {
        private readonly IWebHostEnvironment _hostEnvironment;

        public ImageController(IWebHostEnvironment hostEnvironment)
        {
            _hostEnvironment = hostEnvironment;
        }

        [HttpGet("get/{imageName}")]
        public IActionResult GetImage(string imageName)
        {
            if (string.IsNullOrWhiteSpace(imageName))
                return BadRequest("Image name is required.");

            var uploadsFolder = Path.Combine(_hostEnvironment.WebRootPath, "uploads");
            var filePath = Path.Combine(uploadsFolder, imageName);

            if (!System.IO.File.Exists(filePath))
                return NotFound("Image not found.");

            var fileBytes = System.IO.File.ReadAllBytes(filePath);

            return File(fileBytes, "image/png", imageName);
        }

        [HttpPost("upload")]
        public async Task<IActionResult> UploadImage([FromForm] IFormFile image)
        {
            if (image == null || image.Length == 0)
                return BadRequest("No file was uploaded.");

            var uploadsFolder = Path.Combine(_hostEnvironment.WebRootPath, "uploads");

            if (!Directory.Exists(uploadsFolder))
                Directory.CreateDirectory(uploadsFolder);

            var uniqueFileName = Guid.NewGuid().ToString() + Path.GetExtension(image.FileName);
            var filePath = Path.Combine(uploadsFolder, uniqueFileName);

            using (var fileStream = new FileStream(filePath, FileMode.Create))
                await image.CopyToAsync(fileStream);

            return Ok(new { Url = uniqueFileName });
        }

        [HttpDelete("delete/{imageName}")]
        public IActionResult DeleteImage(string imageName)
        {
            if (string.IsNullOrWhiteSpace(imageName))
                return BadRequest("Image name is required.");

            var uploadsFolder = Path.Combine(_hostEnvironment.WebRootPath, "uploads");
            var filePath = Path.Combine(uploadsFolder, imageName);

            if (!System.IO.File.Exists(filePath))
                return NotFound("Image not found.");

            System.IO.File.Delete(filePath);

            return Ok(new { Success = true, Message = "Image deleted successfully." });
        }
    }
}
