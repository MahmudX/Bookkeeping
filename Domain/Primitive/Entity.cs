using System.ComponentModel.DataAnnotations;

namespace Domain.Primitive;

public class Entity : IEquatable<Entity>
{
    public override bool Equals(object? obj)
    {
        if (ReferenceEquals(null, obj)) return false;
        if (ReferenceEquals(this, obj)) return true;
        if (obj.GetType() != this.GetType()) return false;
        return Equals((Entity) obj);
    }

    public override int GetHashCode()
    {
        return Id.GetHashCode();
    }

    public Entity()
    {
        Id = Guid.NewGuid();
    }

    [Key]
    public Guid Id { get; set; }
    public bool Equals(Entity? other)
    {
        return other != null && Id == other.Id;
    }

    public static bool operator ==(Entity? left, Entity? right)
    {
        return Equals(left, right);
    }

    public static bool operator !=(Entity? left, Entity? right)
    {
        return !(left == right);
    }
}