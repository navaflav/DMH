using FormApiBackend.Data;
using FormApiBackend.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace FormApiBackend.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ContactController : ControllerBase
    {
        private readonly AppDbContext _context;

        public ContactController(AppDbContext context)
        {
            _context = context; 
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var list = await _context.Contacts.ToListAsync();
            return Ok(list);
        }

        [HttpPost]
        public async Task<IActionResult> CreateContact(Contact contact)
        {
            _context.Contacts.Add(contact);
            await _context.SaveChangesAsync();
            return Ok(contact);
        }

        [HttpPost("login")]
        public async Task<IActionResult> login([FromBody] Loginrespuesta loginData)
        {
            var user = await _context.Contacts.FirstOrDefaultAsync(c =>
               c.Username == loginData.Username && c.Password == loginData.Password);

            if (user == null)
            {
                return Unauthorized("Credenciales inválidas");
            }

            return Ok(new
            {
                nombre = user.Nombre,
                correo = user.Correo,
                celular = user.Celular,
            });
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateContact(int id, [FromBody] Contact updated)
        {
            var contact = await _context.Contacts.FindAsync(id);
            if (contact == null) return NotFound();

            contact.Nombre = updated.Nombre;
            contact.Celular = updated.Celular;
            contact.Correo = updated.Correo;
            contact.Username = updated.Username;
            contact.Password = updated.Password;

            await _context.SaveChangesAsync();
            return Ok(contact);
        }
        //Delete 
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteContact(int id)
        {
            var contact = await _context.Contacts.FindAsync(id);
            if (contact == null) return NotFound();

            _context.Contacts.Remove(contact);
            await _context.SaveChangesAsync();
            return NoContent();
        }


    }
}
